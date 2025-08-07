import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_flutter/models/post_model.dart';

class PostService {
  static const String postUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<PostModel>> listpost() async {
    final response = await http.get(Uri.parse(postUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => PostModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal load data album');
    }
  }
}
