import 'package:get/get.dart';

import '../controllers/carialamat_controller.dart';

class CarialamatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarialamatController>(
      () => CarialamatController(),
    );
  }
}
