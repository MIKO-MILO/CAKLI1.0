import 'package:get/get.dart';
import '../../../../services/token_service.dart';
import '../../../routes/app_pages.dart';

class SettingController extends GetxController {
  Future<void> logout() async {
    await TokenService.clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
