import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aktivitas_controller.dart';

class AktivitasView extends GetView<AktivitasController> {
  const AktivitasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        title: const Text(
          'Aktivitas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFEBE8E8),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Material(
              elevation: 4, // 👈 ini shadow
              shadowColor: Colors.black26,
              child: Container(
                color: const Color(0xFFEBE8E8),
                child: const TabBar(
                  indicatorColor: Color(0xFFE45A1F),
                  tabs: [
                    Tab(text: "Riwayat"),
                    Tab(text: "Dalam proses"),
                    Tab(text: "Terjadwal"),
                    Tab(text: "Draf"),
                  ],
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: ListView(
                      children: const [
                        RiwayatCard(
                          tanggal: "2 Jan, 10:47",
                          lokasi: "SMKN 4 Malang",
                          harga: "Rp. 16.000",
                          selesai: true,
                        ),

                        RiwayatCard(
                          tanggal: "2 Jan, 10:47",
                          lokasi: "SMKN 4 Malang",
                          harga: "Rp. 16.000",
                          selesai: false,
                        ),

                        RiwayatCard(
                          tanggal: "2 Jan, 10:47",
                          lokasi: "SMKN 4 Malang",
                          harga: "Rp. 16.000",
                          selesai: true,
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

class RiwayatCard extends StatelessWidget {
  final String lokasi;
  final String tanggal;
  final String harga;
  final bool selesai;

  const RiwayatCard({
    super.key,
    required this.lokasi,
    required this.tanggal,
    required this.harga,
    required this.selesai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          /// IMAGE
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDAC7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('assets/images/aktivitas/becak.png'),
          ),

          const SizedBox(width: 15),

          /// RIGHT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE + PRICE
                Row(
                  children: [
                    Text(
                      lokasi,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.07),

                    Text(
                      harga,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),

                /// DATE
                Text(
                  tanggal,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 10),

                /// STATUS + BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          selesai ? Icons.check_circle : Icons.cancel,
                          color: selesai ? Colors.green : Colors.red,
                          size: 19,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          selesai
                              ? "Perjalanan selesai"
                              : "Perjalanan dibatalkan",
                          style: TextStyle(
                            fontSize: 13,
                            color: selesai ? Colors.black : Colors.red,
                          ),
                        ),
                      ],
                    ),

                    if (selesai)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE04D04),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          "Mau Lagi",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
