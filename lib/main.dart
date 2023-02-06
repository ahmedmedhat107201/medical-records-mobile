import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:medical_records_mobile/view/screens/home.dart';
import 'package:medical_records_mobile/view/screens/loginScreen.dart';
import 'package:medical_records_mobile/view/screens/sections/disease.dart';
import 'package:medical_records_mobile/view/screens/sections/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(id: '', password: ''),
      routes: {
        HomeScreen.routeID: (context) => const HomeScreen(id: '', password: ''),
        ProfileScreen.routeID: (context) => ProfileScreen(),
        DiseaseScreen.routeID: (context) => DiseaseScreen(),
      },
    );
  }
}
