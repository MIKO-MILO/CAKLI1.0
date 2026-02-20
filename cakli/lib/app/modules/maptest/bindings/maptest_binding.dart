import 'package:get/get.dart';

import '../controllers/maptest_controller.dart';

class MaptestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaptestController>(
      () => MaptestController(),
    );
  }
}
