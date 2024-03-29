import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/medicalRecords/scanMedicalRecord.dart';
import '/view/screens/sections/chat/chatHomeScreen.dart';
import '/view/screens/sections/QRCheckScreen.dart';
import '../screens/sections/medicalRecords/medicalRecordScreen.dart';
import '../../constant.dart';
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
    if (user == null) {
      fetch();
    }
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
                      currentAccountPicture: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: user!.imgSrc == null
                            ? Image.asset(
                                '$imagePath/default.png',
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  '${user!.imgSrc}',
                                ),
                              ),
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
                      leading: Icon(Icons.medical_information_rounded),
                      title: Text("Medical Record"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          MedicalRecordScreen.routeID,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.create_new_folder),
                      title: Text("Create Medical Record"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          QRCheckScreen.routeID,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.create_new_folder),
                      title: Text("Scan Records"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          ScanMedicalRecord.routeID,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.chat),
                      title: Text("Chat"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          ChatHomeScreen.routeID,
                        );
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
