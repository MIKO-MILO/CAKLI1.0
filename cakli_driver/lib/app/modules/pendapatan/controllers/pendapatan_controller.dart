import 'package:get/get.dart';

class PendapatanController extends GetxController {
  //TODO: Implement PendapatanController

  final count = 0.obs;

  void increment() => count.value++;

  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  var saldo = 57800.obs;

  String get formattedSaldo =>
      "Rp ${saldo.value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ".")}";
}
