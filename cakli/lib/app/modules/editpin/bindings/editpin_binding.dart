import 'package:get/get.dart';

import '../controllers/editpin_controller.dart';

class EditpinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditpinController>(
      () => EditpinController(),
    );
  }
}
