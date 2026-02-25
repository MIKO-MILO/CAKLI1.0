import 'package:get/get.dart';

import '../controllers/editalamat_controller.dart';

class EditalamatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditalamatController>(
      () => EditalamatController(),
    );
  }
}
