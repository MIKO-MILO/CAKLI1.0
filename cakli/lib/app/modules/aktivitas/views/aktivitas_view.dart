import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/aktivitas_controller.dart';

class AktivitasView extends GetView<AktivitasController> {
  const AktivitasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Kembali"),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Material(
              elevation: 4, // 👈 ini shadow
              shadowColor: Colors.black26,
              child: Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black, // 🔥 warna tab aktif
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  unselectedLabelColor: Colors.grey, // warna tab tidak aktif
                  indicatorColor: const Color(0xFFE45A1F),
                  tabs: const [
                    Tab(text: "Riwayat",),
                    Tab(text: "Dalam proses"),
                    Tab(text: "Terjadwal"),
                    Tab(text: "Draf"),
                  ],
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: ListView(
                      children: const [
                        RiwayatCard(
                          tanggal: "2 Jan, 10:47",
                          lokasi: "SMKN 4 Malang",
                          harga: "Rp. 16.000",
                          selesai: true,
                          rating: true,
                        ),

                        RiwayatCard(
                          tanggal: "2 Jan, 10:47",
                          lokasi: "SMKN 4 Malang",
                          harga: "Rp. 16.000",
                          selesai: false,
                          rating: true,
                        ),

                        RiwayatCard(
                          tanggal: "2 Jan, 10:47",
                          lokasi: "SMKN 4 Malang",
                          harga: "Rp. 16.000",
                          selesai: true,
                          rating: false,
                        ),
                      ],
                    ),
                  ),
                  Center(child: Text("Dalam Proses Page")),
                  Center(child: Text("Terjadwal Page")),
                  Center(child: Text("Draf Page")),
                ],
              ),
            ),
          ],
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
        decoration: BoxDecoration(color: Colors.white),
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
                  fontWeight: FontWeight.w600,
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

class RiwayatCard extends StatelessWidget {
  final String lokasi;
  final String tanggal;
  final String harga;
  final bool selesai;
  final bool rating;

  const RiwayatCard({
    super.key,
    required this.lokasi,
    required this.tanggal,
    required this.harga,
    required this.selesai,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFCFCFCF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          PictureProfile(),
          SizedBox(width: 10),

          /// RIGHT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(lokasi: lokasi, harga: harga),
                Date(tanggal: tanggal),
                SizedBox(height: 15),
                Bottom(selesai: selesai, rating: rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PictureProfile extends StatelessWidget {
  const PictureProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.width * 0.22,
      decoration: BoxDecoration(
        color: const Color(0xFFFFDAC7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        'assets/images/aktivitas/becak.png',
        width: MediaQuery.of(context).size.width * 0.18,
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String lokasi;
  final String harga;

  const Header({super.key, required this.lokasi, required this.harga});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lokasi,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700),
        ),

        Text(
          harga,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

class Date extends StatelessWidget {
  final String tanggal;

  const Date({super.key, required this.tanggal});

  @override
  Widget build(BuildContext context) {
    return Text(
      tanggal,
      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
    );
  }
}

class Bottom extends StatelessWidget {
  final bool selesai;
  final bool rating;

  const Bottom({super.key, required this.selesai, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Status(selesai: selesai),
        Button(selesai: selesai, rating: rating),
      ],
    );
  }
}

class Status extends StatelessWidget {
  final bool selesai;

  const Status({super.key, required this.selesai});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          selesai ? Icons.check_circle : Icons.cancel,
          color: selesai ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          selesai ? "Perjalanan selesai" : "Perjalanan dibatalkan",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: selesai ? Colors.black : Colors.red,
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final bool selesai;
  final bool rating;

  const Button({super.key, required this.selesai, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (selesai)
          GestureDetector(
            onTap: () {
              rating ? Get.toNamed('/rating') : Get.toNamed('/setlokasi');
            },

            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE04D04),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                rating ? "Ulasan" : "Mau Lagi",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
