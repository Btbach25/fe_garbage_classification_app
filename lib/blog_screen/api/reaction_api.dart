
import 'dart:convert';
import 'package:fe_garbage_classification_app/blog_screen/models/Reaction.dart';
import 'package:fe_garbage_classification_app/start_screen/api/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ReactionApi{
  static const String url = "http://10.0.2.2:8000/blog/post";

  static Future<List<Reaction>> getReaction(int id_post) async {
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


  static Future<Reaction> uploadReaction(int id_post) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.post(
      Uri.parse('$url/$id_post/react/'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
      body: json.encode({
        'reaction_type': 1,
        'content': '$id_post',
      }),
    );
    if(response.statusCode ==201){
      dynamic data = json.decode(response.body); 
      Reaction react = Reaction.fromJson(data); 
      return react;
    }
    else if(response.statusCode == 401){
      //Get access token by refresh token
      await TokenStorage.getaccessToken(refresh_token!);
      // Update access token
      access_token = prefs.getString('refresh_token');

      response = await http.post(
        Uri.parse('$url/$id_post/react/'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
        body: json.encode({
          'reaction_type': 1,
        }),
      );
      if(response.statusCode ==201){
        dynamic data = json.decode(response.body); 
        Reaction react = Reaction.fromJson(data); 
        return react;
      }
      else{
        throw Exception('Fail to upload reaction');
      }
    }
    else {
      throw Exception('Fail to upload reaction');
    }
  }

  static Future<void> deleteReaction(int idReact) async {
    final prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    String? refresh_token = prefs.getString('refresh_token');

    var response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/blog/react/$idReact/delete/'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $access_token',
      },
    );

    if(response.statusCode == 401){
      //Get access token by refresh token
      await TokenStorage.getaccessToken(refresh_token!);
      // Update access token
      access_token = prefs.getString('refresh_token');

      response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/blog/react/$idReact/delete/'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
      );

      if(response.statusCode != 204){
        throw Exception('Fail to unlike');
      }
    }
    else if(response.statusCode !=204){
      throw Exception('Fail to unlike');
    }
  }
}