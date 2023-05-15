import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/chat/chatHomeScreen.dart';
import 'view/screens/sections/chat/chatRoomsScreen.dart';
import 'view/screens/splash_screen.dart';
import 'view/screens/sections/createMedicalRecordScreen.dart';
import 'view/screens/sections/medicalRecordScreen.dart';
import 'view/screens/loginScreen.dart';
import 'view/screens/sections/QRCheckScreen.dart';
import 'view/screens/sections/chat/chatScreen.dart';
import 'view/screens/sections/chat/getDoctorsScreen.dart';
import 'view/screens/sections/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ChatHomeScreen(),
      routes: {
        LoginScreen.routeID: (context) => LoginScreen(),
        HomeScreen.routeID: (context) => HomeScreen(),
        MedicalRecordScreen.routeID: (context) => MedicalRecordScreen(),
        CreateMedicalRecordScreen.routeID: (context) =>
            CreateMedicalRecordScreen(),
        QRCheckScreen.routeID: (context) => QRCheckScreen(),
        ChatHomeScreen.routeID: (context) => ChatHomeScreen(),
        ChatRoomsScreen.routeID: (context) => ChatRoomsScreen(),
        ChatScreen.routeID: (context) => ChatScreen(),
        GetDoctorsScreen.routeID: (context) => GetDoctorsScreen(),
      },
    );
  }
}
