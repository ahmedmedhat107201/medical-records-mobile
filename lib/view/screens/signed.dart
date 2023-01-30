import 'package:flutter/material.dart';

class Signed extends StatelessWidget {
  final String id;
  final String password;

  const Signed({
    required this.id,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Text('$id'),
              Text('$password'),
            ],
          ),
        ),
      ),
    );
  }
}
