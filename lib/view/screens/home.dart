import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final String id;
  final String password;
  static final String routeID = "/HomeScreen";

  const HomeScreen({
    required this.id,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text('Home'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Text('$id'),
            Text('$password'),
          ],
        ),
      ),
    );
  }
}
