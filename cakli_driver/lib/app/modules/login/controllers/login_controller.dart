import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../services/auth_service.dart';
import '../models/login_models.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authService = AuthService();

  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isAppleLoading = false.obs;
  final selectedTab = 0.obs;
  final alertMessage = Rxn<AlertData>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void dismissAlert() => alertMessage.value = null;

  void showAlert(AlertData data) => alertMessage.value = data;

  Future<void> login() async {
    dismissAlert();
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final response = await authService
          .login(emailController.text.trim(), passwordController.text)
          .timeout(const Duration(seconds: 10));

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      switch (response.statusCode) {
        case 200:
          showAlert(
            AlertData.success(
              title: 'Berhasil Masuk',
              message: 'Selamat datang kembali di CakLi!',
            ),
          );
          // Tunggu sebentar sebelum navigasi agar alert sempat tampil
          Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed(Routes.HOME);
          });
          break;
        case 401:
          showAlert(
            AlertData.error(
              title: 'Password Salah',
              message:
                  'Email atau password yang kamu masukkan tidak sesuai. Coba lagi.',
            ),
          );
          break;
        case 404:
          showAlert(
            AlertData.error(
              title: 'Akun Tidak Ditemukan',
              message:
                  'Email ini belum terdaftar. Silakan daftar terlebih dahulu.',
            ),
          );
          break;
        case 429:
          showAlert(
            AlertData.warning(
              title: 'Terlalu Banyak Percobaan',
              message: 'Akun dikunci sementara. Coba lagi dalam 10 menit.',
            ),
          );
          break;
        case 500:
        case 503:
          showAlert(
            AlertData.warning(
              title: 'Server Tidak Tersedia',
              message:
                  'Layanan sedang gangguan. Silakan coba beberapa saat lagi.',
            ),
          );
          break;
        default:
          showAlert(
            AlertData.error(
              title: 'Terjadi Kesalahan',
              message:
                  body['message'] ??
                  'Error tidak diketahui (${response.statusCode})',
            ),
          );
      }
    } catch (e) {
      String title = 'Terjadi Kesalahan';
      String message = 'Terjadi kesalahan tidak terduga. Silakan coba lagi.';

      if (e.toString().contains('TimeoutException')) {
        title = 'Waktu Habis';
        message = 'Server tidak merespon dalam waktu yang ditentukan. Periksa koneksi atau coba lagi nanti.';
      } else if (e.toString().contains('SocketException') ||
          e.toString().contains('Connection failed') ||
          e.toString().contains('Connection refused')) {
        title = 'Server Tidak Tersedia';
        message = 'Tidak dapat menghubungi server. Pastikan server backend sudah menyala dan HP/Emulator kamu terhubung ke jaringan yang sama.';
      }

      showAlert(AlertData.error(title: title, message: message));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    dismissAlert();
    isGoogleLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulasi
    showAlert(
      AlertData.info(
        title: 'Segera Hadir',
        message: 'Login dengan Google belum tersedia.',
      ),
    );
    isGoogleLoading.value = false;
  }

  Future<void> loginWithApple() async {
    dismissAlert();
    isAppleLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulasi
    showAlert(
      AlertData.info(
        title: 'Segera Hadir',
        message: 'Login dengan Apple belum tersedia.',
      ),
    );
    isAppleLoading.value = false;
  }

  void showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Lupa Password?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Kami akan mengirimkan link reset password ke email kamu.',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // TODO: Implement forgot password API
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCC4E0A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Kirim',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
