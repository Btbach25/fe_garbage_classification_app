import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInApi{
  static final _googleSignIn =GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();

  static Future<void> loginWithGoogle(String accessToken) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/auth/google/').replace(queryParameters: {"access_token": accessToken}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(response.body);
      String access_Token = data['access'];
      String refresh_Token = data['refresh'];

      // Save the tokens 
      await prefs.setString('access_token', access_Token);
      await prefs.setString('refresh_token', refresh_Token);
    } else {
      throw Exception('Failed to signin');
    }
  }
}