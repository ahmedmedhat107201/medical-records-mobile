import 'dart:async';
import 'package:flutter/material.dart';
import '/Model/Services/home_api.dart';
import 'sections/homeScreen.dart';
import '/constant.dart';

import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*
    determin whether the access token is valid or not
    if token is not empty
      call the api ((sorry but I have to do this))
      to know whether the access token is valid or not
      if valid
        go to home screen
      else
        go to login screen
    if it's empty
      go to the login
  */

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
          var home = await home_api();
          if (home.nationalId != null) {
            globalToken = token;
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
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Material(
          child: Image.asset(
            '$imagePath/logo.png',
            width: 150,
            height: 150,
          ),
          // elevation: 5,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
