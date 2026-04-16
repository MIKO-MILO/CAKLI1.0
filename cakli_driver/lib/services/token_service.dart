import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenService {
  static const String _key = 'access_token';
  static String? _token;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_key);
  }

  static bool get isLoggedIn => _token != null;

  static Future<void> saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  static Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_key);
    return _token;
  }

  static Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));

      final data = jsonDecode(decoded);

      final exp = data['exp'];
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      return exp < now;
    } catch (e) {
      return true;
    }
  }
}
