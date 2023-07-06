import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class DoctorProfileAPI {
  String? name;
  String? image_src;
  String? medicalSpecialization;
  String? email;
  DoctorData? doctorData;
  Count? count;
  List<Report?>? report;

  DoctorProfileAPI({
    this.name,
    this.image_src,
    this.medicalSpecialization,
    this.email,
    this.doctorData,
    this.count,
    this.report,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image_src': image_src,
      'medicalSpecialization': medicalSpecialization,
      'email': email,
      'DoctorData': doctorData?.toJson(),
      '_count': count?.toJson(),
      'report': report?.map((x) => x?.toJson()).toList(),
    };
  }

  factory DoctorProfileAPI.fromJson(Map<String, dynamic> json) {
    return DoctorProfileAPI(
      name: json['name'] != null ? json['name'] as String : null,
      image_src: json['image_src'] != null ? json['image_src'] as String : null,
      medicalSpecialization: json['medicalSpecialization'] != null
          ? json['medicalSpecialization'] as String
          : null,
      email: json['email'] != null ? json['email'] as String : null,
      doctorData: json['DoctorData'] != null
          ? DoctorData.fromJson(json['DoctorData'] as Map<String, dynamic>)
          : null,
      count: json['count'] != null
          ? Count.fromJson(json['count'] as Map<String, dynamic>)
          : null,
      report: json['report'] != null
          ? List<Report>.from(
              (json['report'] as List<dynamic>).map<Report?>(
                (x) => Report.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class DoctorData {
  num? totalRating;
  bool? hasChatEnabled;
  DoctorData({
    this.totalRating,
    this.hasChatEnabled,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'totalRating': totalRating,
      'hasChatEnabled': hasChatEnabled,
    };
  }

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      totalRating:
          json['totalRating'] != null ? json['totalRating'] as num : null,
      hasChatEnabled: json['hasChatEnabled'] != null
          ? json['hasChatEnabled'] as bool
          : null,
    );
  }
}

class Count {
  int? writtenMedicalRecors;
  Count({
    this.writtenMedicalRecors,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'writtenMedicalRecors': writtenMedicalRecors,
    };
  }

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      writtenMedicalRecors: json['writtenMedicalRecors'] != null
          ? json['writtenMedicalRecors'] as int
          : null,
    );
  }
}

class Report {
  String? name;
  int? Generic;
  int? Diagnosis;
  int? Surgery;
  int? Birth;
  int? Death;
  int? Illness;
  int? Allergy;
  int? LabTest;
  Report({
    this.name,
    this.Generic,
    this.Diagnosis,
    this.Surgery,
    this.Birth,
    this.Death,
    this.Illness,
    this.Allergy,
    this.LabTest,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'Generic': Generic,
      'Diagnosis': Diagnosis,
      'Surgery': Surgery,
      'Birth': Birth,
      'Death': Death,
      'Illness': Illness,
      'Allergy': Allergy,
      'LabTest': LabTest,
    };
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      name: json['name'] != null ? json['name'] as String : null,
      Generic: json['Generic'] != null ? json['Generic'] as int : null,
      Diagnosis: json['Diagnosis'] != null ? json['Diagnosis'] as int : null,
      Surgery: json['Surgery'] != null ? json['Surgery'] as int : null,
      Birth: json['Birth'] != null ? json['Birth'] as int : null,
      Death: json['Death'] != null ? json['Death'] as int : null,
      Illness: json['Illness'] != null ? json['Illness'] as int : null,
      Allergy: json['Allergy'] != null ? json['Allergy'] as int : null,
      LabTest: json['LabTest'] != null ? json['LabTest'] as int : null,
    );
  }
}

Future<DoctorProfileAPI?>? doctorProfile_api(String doctorId) async {
  String url = '$baseUrl/doctors/$doctorId';
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $globalToken',
    },
  );
  if (response.statusCode == 200) {
    return DoctorProfileAPI.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
