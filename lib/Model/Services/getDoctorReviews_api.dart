import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class DoctorReviewAPI {
  String? id;
  String? comment;
  num? rating;
  String? createdAt;
  Reviewer? reviewer;
  DoctorReviewAPI({
    this.id,
    this.comment,
    this.rating,
    this.createdAt,
    this.reviewer,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt,
      'reviewer': reviewer?.toJson(),
    };
  }

  factory DoctorReviewAPI.fromJson(Map<String, dynamic> json) {
    return DoctorReviewAPI(
      id: json['id'] != null ? json['id'] as String : null,
      comment: json['comment'] != null ? json['comment'] as String : '',
      rating: json['rating'] != null ? json['rating'] as num : null,
      createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
      reviewer: json['reviewer'] != null
          ? Reviewer.fromJson(json['reviewer'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Reviewer {
  String? image_src;
  String? name;
  Reviewer({
    this.image_src,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'image_src': image_src,
      'name': name,
    };
  }

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
      image_src: json['image_src'] != null ? json['image_src'] as String : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }
}

Future<List<DoctorReviewAPI?>?> getDoctorReview_api(String? doctorId) async {
  Map<String, dynamic> params = {"doctorId": doctorId};

  Uri uri = Uri.parse(
      'https://medical-records-server1.onrender.com/api/v1/doctors/reviews');
  final finalUri = uri.replace(queryParameters: params);

  final response = await http.get(
    finalUri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $globalToken',
    },
  );
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => DoctorReviewAPI.fromJson(data)).toList();
  } else {
    print(response.body);
    return null;
  }
}
