import 'dart:convert';
import 'package:fe_garbage_classification_app/blog_screen/models/Post.dart';
import 'package:fe_garbage_classification_app/start_screen/api/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Blog_api{
  static const String url ="http://10.0.2.2:8000/blog";

  static Future<List<Post>> getPosts (String check) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.get(
      Uri.parse('$url/$check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
      return posts;
    } else if (response.statusCode == 401) {
      // Get access token by refresh token
      await TokenStorage.getaccessToken(refresh_token!);
      
      // Retry the request with the new access token
      access_token = prefs.getString('access_token');
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<void> uploadPost(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    String? content = post.content;
    String? title = post.title;

    var response = await http.post(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode({
        'content': content,
        'title': title,
      }),
    );

    if (response.statusCode == 401) {
      // Get access token by refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');

      response = await http.post(
        Uri.parse('$url/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
        body: json.encode({
          'content': content,
          'title': title,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to upload posts');
      }
    } else if (response.statusCode != 201) {
      throw Exception('Failed to upload posts');
    }
  }

  static Future<bool> deletePost(int id_post) async{
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.delete(
      Uri.parse('$url/post/$id_post/delete/'),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
      },
    );

    if (response.statusCode == 204){
      return true;
    }
    else if(response.statusCode == 401){
      // Get access token by refresh token
      await TokenStorage.getaccessToken(refresh_token!);

      // Retry the request with the new access token
      access_token = prefs.getString('access_token');

      response = await http.delete(
        Uri.parse('$url/post/$id_post/delete/'),
        headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $access_token',
        },
      );

      if(response.statusCode == 204){
        return true;
      }
      else if(response.statusCode == 404){
        return false;
      };
    };
    return false;
  }
}