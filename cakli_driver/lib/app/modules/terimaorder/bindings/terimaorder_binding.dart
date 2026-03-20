import 'package:get/get.dart';

import '../controllers/terimaorder_controller.dart';

class TerimaorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TerimaorderController>(
      () => TerimaorderController(),
    );
  }
}
