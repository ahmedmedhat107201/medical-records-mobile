import 'dart:convert';
import 'package:http/http.dart' as http;
import '/constant.dart';

class User {
  final String? nationalId;
  final String? name;
  final String? email;
  final String? createdAt;
  final String? updatedAt;
  final int? avg_monthly_income;
  final String? dob;
  final String? educationalLevel;
  final String? employmentStatus;
  final String? maritalStatus;
  final String? gender;
  final String? image_src;
  final int? weight;
  final int? height_cm;

  User({
    this.email,
    this.createdAt,
    this.updatedAt,
    this.avg_monthly_income,
    this.educationalLevel,
    this.employmentStatus,
    this.maritalStatus,
    this.image_src,
    this.weight,
    this.height_cm,
    this.nationalId,
    this.name,
    this.gender,
    this.dob,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nationalId: json['nationalId'],
      name: json['name'],
      gender: json['gender'],
      dob: json['dob'],
      maritalStatus: json['maritalStatus'],
      educationalLevel: json['educationalLevel'],
      employmentStatus: json['employmentStatus'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      avg_monthly_income: json['avg_monthly_income'],
      image_src: json['image_src'],
      weight: json['weight'],
      height_cm: json['height_cm'],
      email: json['email'],
    );
  }
}

Future<User> profile_api() async {
  var accessToken = await storage.read(
    key: 'token',
  );
  final response = await http.get(
    Uri.parse('https://medical-records-server1.onrender.com/api/v1/users/me'),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception('Failed to load the user');
  }
}
