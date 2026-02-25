import 'package:get/get.dart';

import '../controllers/setlokasi_controller.dart';

class SetlokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetlokasiController>(
      () => SetlokasiController(),
    );
  }
}
