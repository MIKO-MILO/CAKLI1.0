import 'package:get/get.dart';

import '../controllers/listchat_controller.dart';

class ListchatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListchatController>(
      () => ListchatController(),
    );
  }
}
