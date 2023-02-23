import 'dart:convert';
import 'package:http/http.dart' as http;

Future login_api(String id, String password) async {
  final response = await http.post(
    Uri.parse('https://medical-records-server1.onrender.com/api/v1/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(
      <String, String>{"nationalId": id, "password": password},
    ),
  );
  print(response.body);
  return response.statusCode;
}
