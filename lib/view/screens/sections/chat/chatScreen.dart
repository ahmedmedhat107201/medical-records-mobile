import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '/Model/Services/getChatMessages_api.dart';
import 'package:medical_records_mobile/constant.dart';

class ChatScreen extends StatefulWidget {
  static final String routeID = '/chatScreen';
  final String? userId;

  const ChatScreen({this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<getChatMessagesApi?>? messagesList;
  List<Message> fixedMessages = [];

  TextEditingController _controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messagesList = getChatMessages_api(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      appBar: AppBar(
        title: Center(child: Text("Chat Screen")),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<getChatMessagesApi?>(
                future: messagesList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    var messages = snapshot.data!.messages!;
                    if (fixedMessages.isEmpty) {
                      for (var message in messages) {
                        final m = Message(
                          isMe: message.isMe!,
                          value: message.value!,
                          createdAt: message.createdAt!,
                          senderName: snapshot.data!.otherUser!.name!,
                          image: snapshot.data!.otherUser!.image_src!,
                        );
                        fixedMessages.add(m);
                      }
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    }

                    return ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: fixedMessages.length,
                      itemBuilder: (context, index) {
                        // var data = snapshot.data![index]!;
                        var data2 = fixedMessages[index];
                        String? globalUserImg = globalUser!.image_src;
                        return Message(
                          senderName: data2.isMe ? 'Me' : data2.senderName,
                          value: data2.value,
                          isMe: data2.isMe,
                          createdAt: data2.createdAt,
                          image: data2.isMe ? globalUserImg : data2.image,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            //input button and text field
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Enter a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          String messageText = _controller.text;
                          fixedMessages.add(
                            Message(
                              value: messageText,
                              isMe: true,
                              createdAt: DateTime.now().toString(),
                              senderName: 'Sender',
                              image: null,
                            ),
                          );
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                          _controller.clear();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  Message({
    required this.senderName,
    required this.value,
    required this.isMe,
    required this.createdAt,
    required this.image,
  });

  final String senderName;
  final String value;
  final bool isMe;
  final String? createdAt;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            senderName,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
            elevation: 10.0,
            color: isMe ? primaryColor : Colors.grey.shade300,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                !isMe
                    ? CircleAvatar(
                        radius: 24,
                        backgroundImage: image == null
                            ? Image.asset('$imagePath/default.png').image
                            : Image.network('${image}').image,
                      )
                    : Container(),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey.shade800,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                isMe
                    ? CircleAvatar(
                        radius: 24,
                        backgroundImage: image == null
                            ? Image.asset('$imagePath/default.png').image
                            : Image.network('${image}').image,
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            formateDateTimeToTime(createdAt.toString()),
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
// static final String routeID = '/chatScreen';
