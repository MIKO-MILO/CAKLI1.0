import 'package:get/get.dart';
import 'package:cakli_driver/services/api_service.dart';
import 'package:cakli_driver/app/modules/profil/views/profil_view.dart';
import '../../../../services/token_service.dart';
import '../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  final ApiService apiService = ApiService();

  final Rx<UserModel> user = UserModel(
    name: '',
    email: '',
    phone: '',
    userId: '',
  ).obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final driver = await apiService.getDriverProfile();

      user.value = UserModel(
        name: driver.name,
        email: driver.email,
        phone: driver.phone,
        userId: driver.id,
      );
    } catch (e) {
      print("ERROR FETCH PROFILE: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onEditTapped() {
    Get.snackbar('Edit Profile', 'Buka halaman edit profil...');
  }

  Future<void> logout() async {
    await TokenService.clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
