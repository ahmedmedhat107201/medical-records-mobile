import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';

Widget MedicalRecordFormField({
  double cursorWidth = 2.0,
  required TextEditingController control,
  required String label,
  required validate,
  IconData,
  keyboardType,
  onsubmit,
  final onTap,
  readOnly = false,
}) =>
    TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      cursorWidth: cursorWidth,
      controller: control,
      onFieldSubmitted: onsubmit,
      keyboardType: keyboardType,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: IconData,
        labelText: label,
        labelStyle: TextStyle(
          color: primaryColor,
        ),
        fillColor: primaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
