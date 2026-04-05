import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cakli_driver/app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Riwayat'), backgroundColor: Colors.white),
      body: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          const SizedBox(height: 20),
          DateSelector(),
          const SizedBox(height: 20),
          SaldoCard(),
          const SizedBox(height: 10),
          TripView(),
          const SizedBox(height: 20),
          HistoryView(
            harga: 'Rp. 7000',
            status: 'Selesai',
            time: '16:48 - 16:53',
            idTransaksi: 'ID transaksi: GK-91-1222377',
            locationJemput: 'Jl. Pandanwangi Residen..',
            locationTujuan: 'Jl. Laksa Adi Sucipto no 99',
            poin: '+300',
            location: 'Jl. Pandanwangi Residen..',
            metodePembayaran: false,
          ),

          HistoryView(
            harga: 'Rp. 7000',
            status: 'Selesai',
            time: '16:48 - 16:53',
            idTransaksi: 'ID transaksi: GK-91-1222377',
            locationJemput: 'Jl. Pandanwangi Residen..',
            locationTujuan: 'Jl. Laksa Adi Sucipto no 99',
            poin: '+50',
            location: 'Jl. Pandanwangi Residen..',
            metodePembayaran: true,
          ),
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
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
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
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dates.map((date) {
                bool isSelected =
                    date.day == selected.day && date.month == selected.month;

                bool isCurrentMonth = date.month == selected.month;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
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
                          style: GoogleFonts.poppins(
                            height: 1,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
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
                          style: GoogleFonts.poppins(
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
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= TAB =================
            Padding(
              padding: const EdgeInsets.all(
                16,
              ), // ⬅️ padding hanya untuk text tab
              child: Column(
                children: [
                  /// TEXT TAB
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(0),
                          child: Center(
                            child: Text(
                              "Total Saldo",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: controller.selectedTab.value == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(1),
                          child: Center(
                            child: Text(
                              "Laba Bersih",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: controller.selectedTab.value == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// 🔥 GARIS DI LUAR PADDING
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),

                    AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      alignment: controller.selectedTab.value == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        height: 2,
                        width: constraints.maxWidth / 2,
                        color: const Color(0xFFE04D04),
                      ),
                    ),
                  ],
                );
              },
            ),

            /// ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(16), // ⬅️ content tetap ada padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  if (controller.selectedTab.value == 0) ...[
                    Text(
                      "Total Pendapatan",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Rp 57.800",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Pendapatan Bersih",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Rp 32.500",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 👈 ini baru kepake
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trip Selesai',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '5',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          Divider(height: 20, color: Colors.grey),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trip Cancel',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '0',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HistoryView extends StatelessWidget {
  final String harga;
  final String status;
  final String time;
  final String location;
  final String idTransaksi;
  final String locationJemput;
  final String locationTujuan;
  final String poin;
  final bool metodePembayaran;

  const HistoryView({
    super.key,
    required this.harga,
    required this.status,
    required this.time,
    required this.location,
    required this.idTransaksi,
    required this.locationJemput,
    required this.locationTujuan,
    required this.poin,
    required this.metodePembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.TERIMAORDER);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  harga,
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE04D04),
                  ),
                ),
              ],
            ),

            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              idTransaksi,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),

            Divider(height: 30, color: Colors.grey),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ICON + GARIS
                Column(
                  children: [
                    // titik atas (pickup)
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE04D04),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),

                    // garis putus-putus
                    DottedLine(
                      direction: Axis.vertical,
                      lineLength: 20,
                      dashLength: 4,
                      dashColor: Colors.grey,
                    ),

                    // titik bawah (tujuan)
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.circle, color: Colors.white, size: 10),
                    ),
                  ],
                ),

                SizedBox(width: 12),

                // TEXT LOKASI
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locationJemput,
                        style: GoogleFonts.poppins(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              locationTujuan,
                              style: GoogleFonts.poppins(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icon/poin.png'),

                      SizedBox(width: 4),
                      Text(
                        poin,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12),

                Container(
                  padding: EdgeInsets.all(8),
                  width: metodePembayaran ? 90 : 110,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      metodePembayaran
                          ? Image.asset('assets/images/icon/money.png')
                          : Icon(
                              Symbols.account_balance_wallet,
                              fill: 1,
                              color: const Color(0xFFE04D04),
                            ),

                      SizedBox(width: 4),
                      metodePembayaran
                          ? Text(
                              'Tunai',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            )
                          : Text(
                              'Capay',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
