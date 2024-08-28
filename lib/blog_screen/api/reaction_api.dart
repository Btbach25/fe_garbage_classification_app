
import 'dart:convert';
import 'package:fe_garbage_classification_app/blog_screen/models/Reaction.dart';
import 'package:fe_garbage_classification_app/start_screen/network/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ReactionApi{
  static const String url = "http://10.0.2.2:8000/blog/post";

  static Future<List<Reaction>> getReaction(String id_post) async {
      final prefs = await SharedPreferences.getInstance();
      String? access_token = prefs.getString('access_token');
      String? refresh_token = prefs.getString('refresh_token');

      var response = await http.get(
      Uri.parse('$url/$id_post/react/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Reaction> Reactions = data.map((json) => Reaction.fromJson(json)).toList();
      return Reactions;
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
        List<Reaction> Reactions = data.map((json) => Reaction.fromJson(json)).toList();
        return Reactions;
      } else {
        throw Exception('Failed to load Reactions');
      }
    } else {
      throw Exception('Failed to load Reactions');
    }
  }
}