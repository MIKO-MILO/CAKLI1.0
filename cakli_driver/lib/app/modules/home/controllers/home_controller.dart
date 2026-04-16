import 'package:get/get.dart';
import 'package:cakli_driver/services/api_service.dart';
import 'package:cakli_driver/services/token_service.dart';
import 'package:cakli_driver/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  void increment() => count.value++;

  final api = ApiService();

  @override
  void onInit() {
    super.onInit();
    checkAuthAndLoad();
  }

  Future<void> checkAuthAndLoad() async {
    try {
        // 🔥 coba ambil profile (validasi token)
        await api.getDriverProfile();

      // kalau sukses → lanjut
        print("Token valid");
      } catch (e) {
      // 🔥 kalau error (401 biasanya)
      print("Token Habis");

      await TokenService.clearToken();

      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
