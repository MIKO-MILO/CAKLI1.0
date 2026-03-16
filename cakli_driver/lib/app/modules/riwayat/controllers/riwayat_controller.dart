import 'package:get/get.dart';

class RiwayatController extends GetxController {
  //TODO: Implement RiwayatController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  var selectedDate = DateTime.now().obs;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void nextDay() {
    selectedDate.value = selectedDate.value.add(const Duration(days: 1));
  }

  void prevDay() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
  }

  List<DateTime> generateDates() {
    DateTime center = selectedDate.value;

    return List.generate(5, (index) => center.add(Duration(days: index - 2)));
  }

  String getDayName(int weekday) {
    const days = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu",
    ];

    return days[weekday - 1];
  }

  String getMonthName(int month) {
    const months = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    return months[month - 1];
  }

  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
