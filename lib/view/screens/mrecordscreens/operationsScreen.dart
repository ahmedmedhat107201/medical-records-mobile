import 'package:flutter/material.dart';
import 'package:medical_records_mobile/Model/Services/home_api.dart';
import 'package:medical_records_mobile/constant.dart';

import '../sections/madicalRecordOld.dart';

class Operation extends StatelessWidget {
  static final String routeID = '/operation';
  @override
  Widget build(BuildContext context) {
    List<User> operation_info = [];
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: Center(
              child: Text('Medical Record'),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicalRecordScreenOld()));
              },
              icon: Icon(Icons.arrow_back),
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              height: 900,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, Index) => Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    width: double.infinity,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Operation Name",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Operation Date",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                itemCount: 70,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 15),
              ),
            ),
          ),
        ));
  }
}
