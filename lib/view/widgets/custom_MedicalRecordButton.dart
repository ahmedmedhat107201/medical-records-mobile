import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';

Widget MRCard({
  required Function() onpressed,
  required String label,
}) =>
    Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(60),
      ),
      width: double.infinity,
      height: 90,
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
