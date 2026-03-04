import 'package:get/get.dart';

import '../controllers/pesanalamat_controller.dart';

class PesanalamatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanalamatController>(
      () => PesanalamatController(),
    );
  }
}
