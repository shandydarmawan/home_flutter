import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_flutter/models/photo_model.dart';

class PhotoService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/photos';

  static Future<List<PhotoModel>> listphoto() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => PhotoModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data foto');
    }
  }
}
