// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class MedicalRecordApi {
  String? id;
  String? userId;
  String? title;
  List<MedicalRecordDetail>? details;
  String? doctorId;
  String? createdAt;
  DateTime? updatedAt;
  bool? lifetime;
  String? actionType;
  MedicalRecordDoctor? doctor;

  MedicalRecordApi({
    this.id,
    this.userId,
    this.title,
    this.details,
    this.doctorId,
    this.createdAt,
    this.updatedAt,
    this.lifetime,
    this.actionType,
    this.doctor,
  });

  factory MedicalRecordApi.fromJson(Map<String, dynamic> json) {
    return MedicalRecordApi(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      details: json['details'] != null
          ? List<MedicalRecordDetail>.from(
              (json['details'] as List<dynamic>).map<MedicalRecordDetail?>(
                (x) => MedicalRecordDetail.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      doctorId: json['doctorId'],
      createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
      lifetime: json['lifetime'],
      actionType: json['actionType'],
      // doctor: json['doctor'] != null
      //     ? MedicalRecordDoctor.fromJson(json['doctor'] as Map<String, dynamic>)
      //     : null,
    );
  }
}

class MedicalRecordDetail {
  String? key;
  String? type;
  dynamic value;
  MedicalRecordDetail({
    this.key,
    this.type,
    required this.value,
  });

  factory MedicalRecordDetail.fromJson(Map<String, dynamic> json) {
    return MedicalRecordDetail(
      key: json['key'],
      type: json['type'],
      value: json['value'],
    );
  }
}

class MedicalRecordDoctor {
  String? id;
  String? name;
  String? email;
  String? image_src;
  String? medicalSpecialization;
  MedicalRecordDoctor({
    this.id,
    this.name,
    this.email,
    this.image_src,
    this.medicalSpecialization,
  });

  factory MedicalRecordDoctor.fromJson(Map<String, dynamic> json) {
    return MedicalRecordDoctor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image_src: json['image_src'],
      medicalSpecialization: json['medicalSpecialization'],
    );
  }
}

Future<List<MedicalRecordApi?>?> medicalRecord_api(String? actionType) async {
  var accessToken = await storage.read(key: 'token');
  var params = {"actionType": actionType == '' ? null : actionType};

  Uri uri = Uri.parse('$baseUrl/records');
  final finalUri = uri.replace(queryParameters: params);

  final response = await http.get(
    finalUri,
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => MedicalRecordApi.fromJson(data)).toList();
  } else {
    print(response.body);
    return null;
  }
}
