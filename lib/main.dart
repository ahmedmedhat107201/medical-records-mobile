import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Login")),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text("Hello"),
        ),
      ),
    );
  }
}
