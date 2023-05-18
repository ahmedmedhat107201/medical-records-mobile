import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/chat/chatScreen.dart';
import '../../../../Model/Services/getChatRooms_api.dart';
import '/constant.dart';

class ChatRoomsScreen extends StatefulWidget {
  static final String routeID = '/chatRoomsScreen';

  @override
  State<ChatRoomsScreen> createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  List<GetChatRoomsApi?>? roomsList;
  bool load = false;
  void fetch() async {
    setState(() {
      load = true;
    });
    roomsList = await getChatRooms_api();
    globalRoomsList = roomsList;
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (globalDoctorList != null) {
      roomsList = globalRoomsList;
    } else if (roomsList == null) {
      fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Column(
              children: [
                Expanded(
                  child: roomsList!.isEmpty
                      ? Center(
                          child: Text(
                            'No Doctors to chat with',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: roomsList!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemBuilder: (context, index) {
                            var room = roomsList![index]!;
                            return RoomCard(room: room);
                          },
                        ),
                ),
              ],
            ),
          );
  }
}

class RoomCard extends StatelessWidget {
  const RoomCard({
    required this.room,
  });

  final GetChatRoomsApi room;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: room.otherUser!.image_src == null
                ? Image.asset('$imagePath/default.png').image
                : Image.network('${room.otherUser!.image_src}').image,
          ),
          SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                String? id = room.otherUser!.id;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(userId: id!),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    room.otherUser!.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    room.lastMessage!.value!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formateDateTimeToTime('${room.lastMessage!.createdAt}'),
                // '09:02',
                style: TextStyle(color: Colors.grey.shade600),
              )
            ],
          ),
        ],
      ),
    );
  }
}
