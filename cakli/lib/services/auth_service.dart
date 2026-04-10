import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class AuthService {
  // Gunakan 10.0.2.2 untuk emulator Android, localhost untuk yang lain
  static String get _baseUrl {
    if (kIsWeb) return "http://localhost:8080";
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "http://10.0.2.2:8080";
    }
    return "http://localhost:8080";
  }

  final String baseUrl = _baseUrl;

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/user/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      String token = body['data']['access_token'];

      // 🔥 simpan token
      await TokenService.saveToken(token);
    }

    return response;
  }
}
