import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/medicalRScreen.dart';
import '/view/screens/loginScreen.dart';
import 'view/screens/sections/homeScreen.dart';
import 'view/screens/sections/diseaseScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        LoginScreen.routeID: (context) => LoginScreen(),
        HomeScreen.routeID: (context) => HomeScreen(),
        DiseaseScreen.routeID: (context) => DiseaseScreen(),
        MedicalRecordScreen.routeID: (context) => MedicalRecordScreen(),
      },
    );
  }
}
