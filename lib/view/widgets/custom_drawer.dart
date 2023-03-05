// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../constant.dart';
import '../screens/sections/diseaseScreen.dart';
import '../screens/sections/homeScreen.dart';
import '/view/screens/loginScreen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class UserData {
  final String? name;
  final String? nationalId;
  final String? imgSrc;

  UserData({
    this.name,
    this.nationalId,
    this.imgSrc,
  });
}

class _CustomDrawerState extends State<CustomDrawer> {
  /*
    the same technic used in the home screen loading the data
  */

  UserData? user;
  bool getDataLoading = true;

  void fetch() async {
    setState(() {
      getDataLoading = true;
    });
    user = UserData(
      name: await storage.read(key: 'userName'),
      nationalId: await storage.read(key: 'userNatId'),
      imgSrc: await storage.read(key: 'userImage'),
    );
    setState(() {
      getDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    // if (user == null) {
    fetch();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: SingleChildScrollView(
          child: getDataLoading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                      accountEmail: Text("${user!.nationalId}"),
                      accountName: Text("${user!.name}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.home_rounded),
                      title: Text("Home"),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeID,
                          (route) => false,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.emoji_emotions_rounded),
                      title: Text("Disease"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, DiseaseScreen.routeID);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Log Out"),
                      onTap: () async {
                        await storage.write(key: 'token', value: '');
                        await storage.write(key: 'userName', value: '');
                        await storage.write(key: 'userEmail', value: '');
                        await storage.write(key: 'userImage', value: '');
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeID,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
