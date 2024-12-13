import 'dart:convert';
import 'package:flutter_testing/api_app/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client httpClient;

  ApiService(this.httpClient);

  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetch Posts
  Future<List<Post>> fetchPosts() async {
    final response = await httpClient.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  //  Fetch Post By Id

  Future<Post> fetchPostById(int id) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
