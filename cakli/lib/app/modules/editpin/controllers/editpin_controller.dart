import 'package:get/get.dart';

class EditpinController extends GetxController {
  //TODO: Implement EditpinController

  final count = 0.obs;



  void increment() => count.value++;

  var pin = ''.obs;

  void addDigit(String digit) {
    if (pin.value.length < 6) {
      pin.value += digit;
    }
  }

    void removeDigit() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }
}
