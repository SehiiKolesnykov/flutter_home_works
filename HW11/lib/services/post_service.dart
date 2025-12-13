import 'dart:convert';

import 'package:post_viewer/models/comment.dart';
import 'package:post_viewer/models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    }  else {
      throw Exception('Failed to load posts');
    }
  }

  Future <List<Comment>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    }  else {
      throw Exception('Failed to load comments');
    }
  }

  Future<bool> deletePost(int postId) async {
   final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));

   if (response.statusCode == 200) {
     return true;
   }  else {
     throw Exception('Failed to delete post');
   }
  }
}