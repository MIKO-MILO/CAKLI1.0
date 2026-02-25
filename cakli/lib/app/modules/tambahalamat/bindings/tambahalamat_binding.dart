import 'package:get/get.dart';

import '../controllers/tambahalamat_controller.dart';

class TambahalamatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahalamatController>(
      () => TambahalamatController(),
    );
  }
}
