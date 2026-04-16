import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';
import 'api_service.dart';

class AuthService {
  final String baseUrl = ApiService.baseUrl;

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/driver/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      String token = body['data']['access_token'];

      // 🔥 simpan token
      await TokenService.saveToken(token);
    }

    return response;
  }
}
