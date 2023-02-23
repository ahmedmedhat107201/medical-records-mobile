import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final response = await http.get(
    Uri.parse('https://medical-records-server1.onrender.com/api/v1/users/me'),
    headers: <String, String>{
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImViZmQ0ZWYwLWI0MDYtNDc0Ni1iZDVjLTc0MzNlODNkMzk3MCIsIm5hdGlvbmFsSWQiOiIyMTExMTExMTExMTExMSIsIm5hbWUiOiJtb2hhbW1lZCBhaG1lZCIsImVtYWlsIjoibW9oYW1tZWQxODIwMDExOEBnbWFpbC5jb20iLCJjcmVhdGVkQXQiOiIyMDIzLTAyLTE3VDEzOjM2OjM5LjE4M1oiLCJ1cGRhdGVkQXQiOiIyMDIzLTAyLTIzVDE4OjQyOjMyLjAzMFoiLCJnZW5kZXIiOiJNYWxlIiwiZG9iIjoiMjAwMS0wOS0yN1QwMDowMDowMC4wMDBaIiwiYXZnX21vbnRobHlfaW5jb21lIjpudWxsLCJpc19hZG1pbiI6ZmFsc2UsIndlaWdodCI6bnVsbCwiaGVpZ2h0X2NtIjpudWxsLCJpbWFnZV9zcmMiOiIvaW1hZ2VzL2RlZmF1bHRfcHAuanBnIiwibWFyaXRhbFN0YXR1c0lkIjoxNiwiZWR1Y2F0aW9uYWxMZXZlbElkIjo2LCJlbXBsb3ltZW50U3RhdHVzSWQiOjE3LCJpYXQiOjE2NzcxNzgwODcsImV4cCI6MTY3NzE4MTY4N30.S0O2m5dq31N_xHoJAS5FLM55SdxDv-3yvlI5UD0hEzw',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception('Failed to load the user');
  }
}
