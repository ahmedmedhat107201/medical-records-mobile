import 'package:flutter/material.dart';
import '/view/screens/sections/createMedicalRecordScreen.dart';
import '/view/screens/sections/medicalRecordScreen.dart';
import '/view/screens/loginScreen.dart';
import 'view/screens/sections/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicalRecordScreen(),
      routes: {
        LoginScreen.routeID: (context) => LoginScreen(),
        HomeScreen.routeID: (context) => HomeScreen(),
        MedicalRecordScreen.routeID: (context) => MedicalRecordScreen(),
        CreateMedicalRecordScreen.routeID: (context) =>
            CreateMedicalRecordScreen(),
      },
    );
  }
}
