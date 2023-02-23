import 'package:flutter/material.dart';
import '../../../constant.dart';
import '../../widgets/custom_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static final String routeID = '/profileScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text('Profile'),
        ),
      ),
    );
  }
}
