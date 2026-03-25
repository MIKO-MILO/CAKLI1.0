
import 'package:cakli_driver/app/modules/profil/views/profil_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  //TODO: Implement ProfilController

  final count = 0.obs;



  void increment() => count.value++;

  final Rx<UserModel> user = UserModel(
    name: 'Aulia Sukma R.',
    email: 'auliasr.edu@gmail.com',
    phone: '+6212312312323123',
    userId: 'AD527A4PE',
  ).obs;

  void onEditTapped() {
    // Navigate to edit profile page
    Get.snackbar(
      'Edit Profile',
      'Buka halaman edit profil...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD84315),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }
}
