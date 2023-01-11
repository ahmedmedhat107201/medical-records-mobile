import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';
import 'package:medical_records_mobile/view/screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Login")),
          backgroundColor: primaryColor,
        ),
        body: LoginScreen(),
      ),
    );
  }
}
