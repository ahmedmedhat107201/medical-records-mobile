import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../widgets/custom_drawer.dart';
import '/Model/Services/profile_api.dart';

class HomeScreen extends StatefulWidget {
  static final String routeID = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = profile_api();
    print("ahmed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text("Home"),
        ),
      ),
      body: Container(
        child: FutureBuilder<User>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("Name"),
                          title: Text("${snapshot.data!.name}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("nationalId"),
                          title: Text("${snapshot.data!.nationalId}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("email"),
                          title: Text("${snapshot.data!.email}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("createdAt"),
                          title: Text("${snapshot.data!.createdAt}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("updatedAt"),
                          title: Text("${snapshot.data!.updatedAt}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("avg_monthly_income"),
                          title: Text("${snapshot.data!.avg_monthly_income}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("dob"),
                          title: Text("${snapshot.data!.dob}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("educationalLevel"),
                          title: Text("${snapshot.data!.educationalLevel}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("employmentStatus"),
                          title: Text("${snapshot.data!.employmentStatus}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("gender"),
                          title: Text("${snapshot.data!.gender}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("image_src"),
                          title: Text("${snapshot.data!.image_src}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("weight"),
                          title: Text("${snapshot.data!.weight}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("height_cm"),
                          title: Text("${snapshot.data!.height_cm}"),
                        ),
                      ),
                      Card(
                        color: primaryColor,
                        child: ListTile(
                          leading: Text("maritalStatus"),
                          title: Text("${snapshot.data!.maritalStatus}"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
      ),
    );
  }
}
