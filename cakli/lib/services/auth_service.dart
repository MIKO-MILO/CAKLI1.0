import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class AuthService {
  // Ganti ke 10.0.2.2 jika menggunakan emulator Android
  final String baseUrl = "http://localhost:8080";

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
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
