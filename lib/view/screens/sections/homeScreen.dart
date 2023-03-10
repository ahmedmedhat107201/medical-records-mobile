import 'package:flutter/material.dart';
import '../../../constant.dart';
import '../../widgets/custom_drawer.dart';
import '../../../Model/Services/home_api.dart';

class HomeScreen extends StatefulWidget {
  static final String routeID = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    load the data between the 2 setStates 
    while 'load' boolean is true
      it's loading
    when false
      data loaded successfully
  */

  User? user;
  bool load = false;

  void fetch() async {
    setState(() {
      load = true;
    });
    user = await home_api();
    setState(() {
      load = false;
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
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text("Home"),
        ),
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Card(
                      color: primaryColor,
                      child: ListTile(
                        leading: Text("Name"),
                        title: Text("${user!.name}"),
                      ),
                    ),
                    Card(
                      color: primaryColor,
                      child: ListTile(
                        leading: Text("nationalId"),
                        title: Text("${user!.nationalId}"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
