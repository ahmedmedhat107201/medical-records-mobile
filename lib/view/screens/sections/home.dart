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
                    ],
                  ),
                ),
              );
            } else if (!(snapshot.connectionState == ConnectionState.done)) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
      ),
    );
  }
}
