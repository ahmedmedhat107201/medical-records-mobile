import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/chat/chatRoomsScreen.dart';
import '/view/screens/sections/chat/getDoctorsScreen.dart';
import '/constant.dart';
import '/view/widgets/custom_drawer.dart';

class ChatHomeScreen extends StatefulWidget {
  static final String routeID = '/chatHomeScreen';

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  var selectedOption;
  var options = [
    'All Specializations',
    'Surgical',
    'Dentistry',
    'Radiography',
    'Emergency',
    'Nursing',
    'Optometric',
    'Cardiovascular',
    'Infectious',
    'DietNutrition',
    'Dermatology',
    'Hematologic',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(
            child: Text('CHAT'),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            MyTabBar(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: secondryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: TabBarView(
                  children: [
                    //1st tab
                    ChatRoomsScreen(),
                    //2nd tab
                    GetDoctorsScreen(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: TabBar(
        indicator: ShapeDecoration(
          color: Color.fromARGB(255, 16, 99, 167),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        tabs: [
          Tab(
            icon: Text(
              'Chats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Tab(
            icon: Text(
              'All Doctors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
