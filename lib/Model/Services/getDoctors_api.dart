import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class GetDoctorsApi {
  String? id;
  String? name;
  String? medicalSpecialization;
  String? image_src;

  GetDoctorsApi({
    this.id,
    this.name,
    this.medicalSpecialization,
    this.image_src,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'medicalSpecialization': medicalSpecialization,
      'image_src': image_src,
    };
  }

  factory GetDoctorsApi.fromJson(Map<String, dynamic> json) {
    return GetDoctorsApi(
      id: json['id'],
      name: json['name'],
      medicalSpecialization: json['medicalSpecialization'],
      image_src: json['image_src'],
    );
  }
}

Future<List<GetDoctorsApi?>?> getDoctors_api(
    {String medicalSpecialization = '', String name = ''}) async {
  var accessToken = await storage.read(key: 'token');
  globalToken = accessToken;

  Map<String, dynamic> params;

  if (medicalSpecialization == '') {
    params = {"q": name};
  } else {
    params = {"medicalSpecialization": medicalSpecialization, "q": name};
  }
  Uri uri = Uri.parse('$baseUrl/doctors');
  final finalUri = uri.replace(queryParameters: params);

  final response = await http.get(
    finalUri,
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
    },
  );
  print('API ' + response.statusCode.toString());
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => GetDoctorsApi.fromJson(data)).toList();
  } else {
    return null;
  }
}
