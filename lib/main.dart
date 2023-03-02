import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/splash_screen.dart';
import '../view/screens/loginScreen.dart';
import '../view/screens/sections/home.dart';
import '../view/screens/sections/disease.dart';
import '../view/screens/sections/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        LoginScreen.routeID: (context) => LoginScreen(),
        HomeScreen.routeID: (context) => HomeScreen(),
        ProfileScreen.routeID: (context) => ProfileScreen(),
        DiseaseScreen.routeID: (context) => DiseaseScreen(),
      },
    );
  }
}
