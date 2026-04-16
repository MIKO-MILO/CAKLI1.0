import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../../services/token_service.dart';

class SplashscreenController extends GetxController {
  final count = 0.obs;

  var bgColor = Colors.white.obs;
  var imagePath = 'assets/images/logo.png'.obs;

  var opacity = 1.0.obs;

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    // fade out
    opacity.value = 0;

    await Future.delayed(const Duration(milliseconds: 500));

    // ganti konten
    bgColor.value = Colors.orange;
    imagePath.value = 'assets/images/logo-orange.png';

    // fade in
    opacity.value = 1;

    await Future.delayed(const Duration(milliseconds: 2500));

    final token = await TokenService.getToken();
    if (token != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    startAnimation();
    super.onInit();
  }

}
