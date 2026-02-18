import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashscreenController extends GetxController {
  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.HOME);
    });
  }
}
