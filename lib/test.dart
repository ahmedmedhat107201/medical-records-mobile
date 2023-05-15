import 'package:flutter/material.dart';

class AllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                'All Chats',
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          // itemCount: allChats.length,
          itemBuilder: (context, int index) {
            // final allChat = allChats[index];
            return Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('allChat.avatar'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'allChat.sender.name',
                        ),
                        Text(
                          'allChat.text',
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      5 == 0
                          ? Icon(
                              Icons.done_all,
                              // color: MyTheme.bodyTextTime.color,
                            )
                          : CircleAvatar(
                              radius: 8,
                              // backgroundColor: MyTheme.kUnreadChatBG,
                              child: Text(
                                'allChat.unreadCount.toString()',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      SizedBox(height: 10),
                      Text(
                        'allChat.time',
                        // style: MyTheme.bodyTextTime,
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
