import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class ScannedUser {
  String? id;
  String? image_src;
  String? name;

  ScannedUser({
    this.id,
    this.image_src,
    this.name,
  });

  factory ScannedUser.fromJson(Map<String, dynamic> json) {
    return ScannedUser(
      id: json['id'] != null ? json['id'] as String : null,
      image_src: json['image_src'] != null ? json['image_src'] as String : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }
}

Future generateQRCode_api() async {
  final accessToken = await storage.read(key: 'token');
  final response = await http.post(
    Uri.parse('$baseUrl/users/qr-generate'),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['qrCode'];
  } else {
    return response.statusCode;
  }
}

Future<ScannedUser> scanQRCode_api(String qrCode) async {
  final accessToken = await storage.read(key: 'token');
  final response = await http.post(
    body: (<String, String>{"qrCode": qrCode}),
    Uri.parse(
      'https://medical-records-server1.onrender.com/api/v1/doctors/scan-qrCode',
    ),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return ScannedUser.fromJson(jsonDecode(response.body));
  } else {
    return ScannedUser();
  }
}
