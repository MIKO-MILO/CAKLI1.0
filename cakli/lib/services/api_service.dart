import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cakli/models/user_model.dart';
import 'token_service.dart';

class ApiService {
  // Gunakan 10.0.2.2 untuk emulator Android, localhost untuk yang lain
  static String get _baseUrl {
    if (kIsWeb) return "http://localhost:8080";
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "http://10.0.2.2:8080";
    }
    return "http://localhost:8080";
  }

  final String baseUrl = _baseUrl;

  Future<User> getProfile() async {
    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan, login dulu");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/user/auth/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(body['data']);
    } else {
      throw Exception(body['message'] ?? "Gagal mengambil profil");
    }
  }

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
