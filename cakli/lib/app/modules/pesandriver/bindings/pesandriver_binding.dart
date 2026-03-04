import 'package:get/get.dart';

import '../controllers/pesandriver_controller.dart';

class PesandriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesandriverController>(
      () => PesandriverController(),
    );
  }
}
