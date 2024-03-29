import 'dart:convert';
import 'package:http/http.dart' as http;
import '/constant.dart';

Future login_api(String id, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(
      <String, String>{"nationalId": id, "password": password},
    ),
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    print('object');
    await storage.write(
      key: 'token',
      value: "${json.decode(response.body)['accessToken']}",
    );
    globalToken = await storage.read(key: 'token');
  }

  return response.statusCode;
}
