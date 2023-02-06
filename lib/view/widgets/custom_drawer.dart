import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/disease.dart';
import 'package:medical_records_mobile/view/screens/sections/profile.dart';
import '../../constant.dart';
import '../screens/home.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.green,
              ),
              accountEmail: Text("Ahmed@gmail.com"),
              accountName: Text("Ahmed"),
            ),
            ListTile(
              leading: Icon(Icons.home_rounded),
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.routeID);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box_rounded),
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeID);
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions_rounded),
              title: Text("Disease"),
              onTap: () {
                Navigator.pushNamed(context, DiseaseScreen.routeID);
              },
            ),
          ],
        ),
      ),
    );
  }
}
