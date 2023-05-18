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
  final String? medicalSpecialization;
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
    this.medicalSpecialization,
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
      medicalSpecialization: json['medicalSpecialization'],
    );
  }
}

Future<User?>? home_api() async {
  var accessToken = await storage.read(
    key: 'token',
  );
  globalToken = accessToken;
  final response = await http.get(
    Uri.parse('$baseUrl/users/me'),
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    var user = await User.fromJson(jsonDecode(response.body));

    await storage.write(key: 'userName', value: await user.name);
    await storage.write(key: 'userNatId', value: await user.nationalId);
    await storage.write(key: 'userImage', value: await user.image_src);
    return User.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}
