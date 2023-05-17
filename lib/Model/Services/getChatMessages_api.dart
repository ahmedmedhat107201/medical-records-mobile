import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant.dart';

class getChatMessagesApi {
  String? id;
  String? roomId;
  String? type;
  String? value;
  String? senderId;
  String? createdAt;
  bool? isMe;
  getChatMessagesApi({
    this.id,
    this.roomId,
    this.type,
    this.value,
    this.senderId,
    this.createdAt,
    this.isMe,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'roomId': roomId,
      'type': type,
      'value': value,
      'senderId': senderId,
      'createdAt': createdAt,
      'isMe': isMe,
    };
  }

  factory getChatMessagesApi.fromJson(Map<String, dynamic> json) {
    return getChatMessagesApi(
      id: json['id'],
      roomId: json['roomId'],
      type: json['type'],
      value: json['value'],
      senderId: json['senderId'],
      createdAt: json['createdAt'],
      isMe: json['isMe'],
    );
  }
}

Future<List<getChatMessagesApi?>?>? getChatMessages_api(String? userId) async {
  var accessToken = await storage.read(key: 'token');
  globalToken = accessToken;

  Uri uri = Uri.parse(
      'https://medical-records-server1.onrender.com/api/v1/chat/room-messages/$userId');

  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  print('API ${response.statusCode}');
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse
        .map((data) => getChatMessagesApi.fromJson(data))
        .toList();
  } else {
    return null;
  }
}
