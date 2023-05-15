import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant.dart';

class GetChatRoomsApi {
  String? id;
  String? lastMessageTimestamp;
  LastMessage? lastMessage;
  OtherUser? otherUser;

  GetChatRoomsApi({
    this.id,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.otherUser,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'lastMessage': lastMessage?.toJson(),
      'lastMessageTimestamp': lastMessageTimestamp,
      'otherUser': otherUser?.toJson(),
    };
  }

  factory GetChatRoomsApi.fromJson(Map<String, dynamic> json) {
    return GetChatRoomsApi(
      id: json['id'],
      lastMessageTimestamp: json['lastMessageTimestamp'],
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
      otherUser: json['otherUser'] != null
          ? OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LastMessage {
  String? id;
  String? roomId;
  String? type;
  String? value;
  String? senderId;
  String? createdAt;
  bool? isMe;
  LastMessage({
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

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
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

class OtherUser {
  String? id;
  String? image_src;
  String? name;
  OtherUser({
    this.id,
    this.image_src,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image_src': image_src,
      'name': name,
    };
  }

  factory OtherUser.fromJson(Map<String, dynamic> json) {
    return OtherUser(
      id: json['id'],
      image_src: json['image_src'],
      name: json['name'],
    );
  }
}

Future<List<GetChatRoomsApi?>?>? getChatRooms_api() async {
  var accessToken = await storage.read(key: 'token');
  globalToken = accessToken;

  Uri uri = Uri.parse('$baseUrl/chat/rooms');

  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  print('API ' + response.statusCode.toString());
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => GetChatRoomsApi.fromJson(data)).toList();
  } else {
    return null;
  }
}
