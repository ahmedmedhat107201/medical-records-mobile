import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_records_mobile/Model/Services/profile_api.dart';
import '/view/screens/sections/home.dart';
import '/constant.dart';

import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loading();
    super.initState();
  }

  loading() async {
    var token = await storage.read(key: 'token');

    Timer(const Duration(seconds: 2), () async {
      if (token == "") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeID,
          (route) => false,
        );
      } else {
        try {
          var profile = await profile_api();
          if (profile.name != null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeID,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeID,
              (route) => false,
            );
          }
        } catch (e) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeID,
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.jpg',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
