import 'package:get/get.dart';

import '../controllers/editemail_controller.dart';

class EditemailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditemailController>(
      () => EditemailController(),
    );
  }
}
