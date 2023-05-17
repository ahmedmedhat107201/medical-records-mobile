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
  late Future<List<getChatMessagesApi?>?>? messagesList;
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
              child: FutureBuilder<List<getChatMessagesApi?>?>(
                future: messagesList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    var messages = snapshot.data!;
                    if (fixedMessages.isEmpty) {
                      for (var message in messages) {
                        final m = Message(
                          isMe: message!.isMe!,
                          value: message.value!,
                          createdAt: message.createdAt!,
                          senderId: message.senderId!,
                        );
                        fixedMessages.add(m);
                      }
                    }

                    return ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: fixedMessages.length,
                      itemBuilder: (context, index) {
                        // var data = snapshot.data![index]!;
                        var data2 = fixedMessages[index];
                        return Message(
                          senderId: data2.senderId,
                          value: data2.value,
                          isMe: data2.isMe,
                          createdAt: data2.createdAt,
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
                              senderId: 'Sender',
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
    required this.senderId,
    required this.value,
    required this.isMe,
    required this.createdAt,
  });

  final String senderId;
  final String value;
  final bool isMe;
  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            senderId,
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                value,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.grey.shade800,
                  fontSize: 15.0,
                ),
              ),
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
