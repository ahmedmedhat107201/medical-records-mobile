import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class getChatMessagesApi {
  bool? isPrivateChat;
  OtherUser? otherUser;
  List<Messages>? messages;

  getChatMessagesApi({
    this.isPrivateChat,
    this.otherUser,
    this.messages,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isPrivateChat': isPrivateChat,
      'otherUser': otherUser?.toJson(),
      'messages': messages?.map((x) => x.toJson()).toList(),
    };
  }

  factory getChatMessagesApi.fromJson(Map<String, dynamic> json) {
    return getChatMessagesApi(
      isPrivateChat: json['isPrivateChat'],
      otherUser: json['otherUser'] != null
          ? OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>)
          : null,
      messages: json['messages'] != null
          ? List<Messages>.from(
              (json['messages'] as List<dynamic>).map<Messages?>(
                (x) => Messages.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class Messages {
  String? id;
  String? roomId;
  String? type;
  String? value;
  String? senderId;
  String? createdAt;
  bool? isMe;
  Messages({
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

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
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

Future<getChatMessagesApi?>? getChatMessages_api(String? userId) async {
  var accessToken = await storage.read(key: 'token');
  globalToken = accessToken;

  Uri uri = Uri.parse('$baseUrl/chat/room-messages/$userId');

  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  print('API ${response.statusCode}');
  if (response.statusCode == 200) {
    return getChatMessagesApi.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}
