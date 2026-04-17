import 'dart:convert';
import 'package:cakli_driver/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:cakli_driver/models/driver_model.dart';
import 'token_service.dart';

class ApiService {
  // IP Laptop Anda (cek cmd: ipconfig) agar bisa diakses dari HP asli dalam 1 WiFi
  // Ganti dengan IP laptop Anda jika mengetes di HP asli
  static const String _laptopIp = "192.168.1.100";

  static String get baseUrl {
    if (kIsWeb) return "http://localhost:8080";
    if (defaultTargetPlatform == TargetPlatform.android) {
      // 10.0.2.2 adalah localhost bagi emulator Android
      // Gunakan _laptopIp jika mengetes di HP asli
      return "http://10.0.2.2:8080";
    }
    return "http://localhost:8080";
  }

  Future<Driver> getDriverProfile() async {
    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan, login dulu");
    }

    final response = await http
        .get(
          Uri.parse('$baseUrl/api/v1/driver/auth/me'), // ✅ FIX
          headers: {'Authorization': 'Bearer $token'},
        )
        .timeout(const Duration(seconds: 10));

    await _handleUnauthorized(response);

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Driver.fromJson(body['data']);
    } else {
      throw Exception(body['message'] ?? "Gagal mengambil profil");
    }
  }

  Future<List<Driver>> getDrivers() async {
    final token = await TokenService.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan, login dulu");
    }

    final response = await http
        .get(
          Uri.parse('$baseUrl/api/v1/admin/driver'),
          headers: {'Authorization': 'Bearer $token'},
        )
        .timeout(const Duration(seconds: 10));

    await _handleUnauthorized(response);

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List data = body['data'];
      return data.map((e) => Driver.fromJson(e)).toList();
    } else {
      throw Exception(body['message']);
    }
  }

  Future<void> _handleUnauthorized(http.Response response) async {
    if (response.statusCode == 401) {
      // 🔥 hapus token
      await TokenService.clearToken();

      // 🔥 redirect ke login (reset semua route)
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
