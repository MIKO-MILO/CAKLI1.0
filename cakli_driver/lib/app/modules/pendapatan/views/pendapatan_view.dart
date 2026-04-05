import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../controllers/pendapatan_controller.dart';

class PendapatanView extends GetView<PendapatanController> {
  const PendapatanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Pendapatan'),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              SaldoCard(),
              WalletCard(),
              TextAddWallet(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 26),
                child: AddWallet(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
        ),
        child: Row(
          children: [
            // Tombol Back
            IconButton(
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
            ),
            // Title
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            // Actions (opsional)
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class SaldoCard extends StatelessWidget {
  final controller = Get.find<PendapatanController>();

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
                              "Harian",
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
                              "Mingguan",
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ), // ⬅️ content tetap ada padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  if (controller.selectedTab.value == 0) ...[
                    Text(
                      "Pendapatan Hari Ini",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
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
                      "Pendapatan Minggu Ini",
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.selectedTab.value == 0) ...[
                    Text(
                      '11 Pengantaran Selesai',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE04D04),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Lihat Detail',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      '50 Pengantaran Selesai',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE04D04),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Lihat Detail',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
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

class WalletCard extends StatelessWidget {
  final PendapatanController controller = Get.put(PendapatanController());

  WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => _saldoItem(
                        "Saldo E-Wallet",
                        controller.formattedSaldo,
                      ),
                    ),
                    Obx(
                      () =>
                          _saldoItem("Saldo Dompet", controller.formattedSaldo),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Garis full
          Container(height: 2, color: Color(0xFFE04D04)),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: _menuItem(Icons.add, "Top Up")),
                Expanded(
                  child: _menuItem(Icons.arrow_downward, "Tarik ke Bank"),
                ),
                Expanded(child: _menuItem(Icons.history, "Riwayat transaksi")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _saldoItem(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFE04D04),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),

        /// TEXT AREA DIBUAT SAMA TINGGI
        SizedBox(
          height: 40, // <- penting biar sejajar
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class TextAddWallet extends StatelessWidget {
  TextAddWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 30, left: 30),
      child: Text(
        'Pendapatan tambahan',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class AddWallet extends StatelessWidget {
  const AddWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 130,
          height: 130,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,

            children: [
              Image.asset('assets/images/icon/poin-map.png'),
              Text(
                'Jadwal Operasional',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(width: 16),

        Container(
          width: 130,
          height: 130,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,

            children: [
              Image.asset('assets/images/icon/cash.png'),
              Text(
                'Intensif & Lainnya',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
