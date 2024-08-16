import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String url = 'http://10.0.2.2:8000/api/token/';

  static Future<void> fetchToken(String username, String password) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var data = json.decode(response.body);

      // Get access token and refresh token from the response
      String accessToken = data['access'];
      String refreshToken = data['refresh'];

      // Save the tokens 
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);

      print(prefs.getString('access_token'));
    } else {
      throw Exception('Failed to fetch token');
    }
  }
}
