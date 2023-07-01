import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import '/Model/Services/QR_code_api.dart';
import 'Model/Services/getChatRooms_api.dart';
import 'Model/Services/getDoctors_api.dart';
import 'Model/Services/home_api.dart';
import 'graphql/chat.dart';

const Color? primaryColor = Color.fromARGB(255, 7, 91, 146);

final Color? secondryColor = Colors.grey.shade200;

final storage = const FlutterSecureStorage();

String baseUrl = 'https://medical-records-server1.onrender.com/api/v1';

String imagePath = "assets/images";

String formateDateTimeToDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  final DateFormat formatter = DateFormat('yMMMMd');
  final String formatted = formatter.format(dateTime);
  return formatted;
}

String formateDateTimeToTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  final DateFormat formatter = DateFormat('jm');
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

// user data
User? globalUser = User();
// access token
String? globalToken;
// generated qr code string
String? globalGeneratedQRCode;
// scanned qr code string
String? globalScannedQRCode;
// user scanned that doctor should add medical record
ScannedUser? globalScannedUser;
// all doctor chat list
List<GetDoctorsApi?>? globalDoctorList;
// selected medical specialization of filtered doctor
String globalMedicalSpecialization = 'All Specializations';
// all chat rooms
List<GetChatRoomsApi?>? globalRoomsList;
//graphQL global client

ValueNotifier<GraphQLClient>? graphqlClient;
//subscription option
final subscriptionOptions = SubscriptionOptions(
  document: gql(MESSAGE_RECIEVED),
);
//subscriptionStrean
StreamSubscription<QueryResult>? subscription; // Subscription object
