import 'package:get/get.dart';

import '../controllers/antarorder_controller.dart';

class AntarorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AntarorderController>(
      () => AntarorderController(),
    );
  }
}
