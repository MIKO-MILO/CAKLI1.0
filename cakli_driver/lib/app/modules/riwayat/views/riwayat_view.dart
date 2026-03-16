import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          DateSelector(),
          const SizedBox(height: 20),
          SaldoCard(),
        ],
      ),
    );
  }
}

class DateSelector extends StatelessWidget {
  final controller = Get.put(RiwayatController());

  DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final dates = controller.generateDates();
      final selected = controller.selectedDate.value;

      return Column(
        children: [
          /// HEADER BULAN
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.prevDay,
                child: const Icon(Icons.chevron_left),
              ),

              const SizedBox(width: 10),

              Text(
                controller.getMonthName(selected.month),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 10),

              GestureDetector(
                onTap: controller.nextDay,
                child: const Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(height: 0),

          /// DATE LIST
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dates.map((date) {
                bool isSelected =
                    date.day == selected.day && date.month == selected.month;

                bool isCurrentMonth = date.month == selected.month;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GestureDetector(
                    onTap: () {
                      controller.selectDate(date);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// TANGGAL
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            height: 1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? const Color(0xFFE04D04)
                                : isCurrentMonth
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),

                        /// HARI
                        Text(
                          controller.getDayName(date.weekday),
                          style: TextStyle(
                            height: 1,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isSelected
                                ? const Color(0xFFE04D04)
                                : isCurrentMonth
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}

class SaldoCard extends StatelessWidget {
  final controller = Get.find<RiwayatController>();

  SaldoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 26),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TAB
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// TAB 1
                GestureDetector(
                  onTap: () => controller.changeTab(0),
                  child: Column(
                    children: [
                      Text(
                        "Total Saldo",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: controller.selectedTab.value == 0
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2,
                        width: 100,
                        color: controller.selectedTab.value == 0
                            ? const Color(0xFFE04D04)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 30),

                /// TAB 2
                GestureDetector(
                  onTap: () => controller.changeTab(1),
                  child: Column(
                    children: [
                      Text(
                        "Laba Bersih",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: controller.selectedTab.value == 1
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2,
                        width: 100,
                        color: controller.selectedTab.value == 1
                            ? const Color(0xFFE04D04)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// CONTENT
            if (controller.selectedTab.value == 0) ...[
              const Text(
                "Total Pendapatan",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "Rp 57.800",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ] else ...[
              const Text(
                "Pendapatan Bersih",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "Rp 32.500",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      );
    });
  }
}
