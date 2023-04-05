import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:medical_records_mobile/Model/Services/QR_code_api.dart';
import 'Model/Services/home_api.dart';

const Color? primaryColor = Color.fromARGB(255, 7, 91, 146);

final storage = const FlutterSecureStorage();

String baseUrl = 'https://medical-records-server1.onrender.com/api/v1';

String imagePath = "assets/images";

String? formateDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  final DateFormat formatter = DateFormat('yMMMMd');
  final String formatted = formatter.format(dateTime);
  return formatted;
}

bool toBool(String text) {
  if (text.toLowerCase() == 'true') {
    return true;
  } else {
    return false;
  }
}

User? globalUser;
String? globalToken;
String? globalGeneratedQRCode;
String? globalScannedQRCode;
ScannedUser? globalScannedUser;
String? errorMessage;
