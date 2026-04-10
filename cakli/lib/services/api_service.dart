import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cakli/models/user_model.dart';
import 'token_service.dart';

class ApiService {
  // Ganti ke 10.0.2.2 jika menggunakan emulator Android
  final String baseUrl = "http://localhost:8080";

  Future<List<User>> getUsers() async {
    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan, login dulu");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/admin/users'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List data = body['data'];
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception(body['message']);
    }
  }
}
