import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cakli/app/routes/app_pages.dart';

class PesandriverView extends StatelessWidget {
  const PesandriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(title: const Text('Pesan Driver')),
      body: Stack(
        children: [
          /// ================= MAP =================
          Positioned.fill(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(-7.9553, 112.6280),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.cakli.app',
                ),
              ],
            ),
          ),

          /// ================= DRAGGABLE SHEET =================
          DraggableScrollableSheet(
            expand: true,
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.82,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// DRAG HANDLE
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        /// ================= HEADER =================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ===== TEXT KIRI =====
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Pengemudi dalam",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    "perjalanan",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),

                              /// ===== TEXT KANAN =====
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "Perkiraan datang",
                                    style: TextStyle(fontSize: 14, height: 1.3),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "dalam",
                                    style: TextStyle(fontSize: 14, height: 1.3),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    "10 menit",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// CARD DRIVER
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// FOTO + KENDARAAN
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/pesandriver/profile.png',
                                        width: 50,
                                      ),
                                      Container(
                                        width: 55,
                                        height: 55,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/images/aktivitas/becak.png',
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// CHAT & CALL
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.CHAT);
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFFD46A2E),
                                            ),
                                          ),
                                          child: Icon(
                                            Symbols.chat,
                                            color: Color(0xFFD46A2E),
                                            fill: 1,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 10),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xFFD46A2E),
                                          ),
                                        ),
                                        child: Icon(
                                          Symbols.call,
                                          color: Color(0xFFD46A2E),
                                          fill: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Row(
                                children: [
                                  Text(
                                    "Alenxander Fabio",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Icon(
                                    Symbols.kid_star,
                                    color: const Color(0xFFFFC905),
                                    size: 20,
                                    fill: 1,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "5.0",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Becak Honda A70s",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Symbols.circle,
                                        size: 15,
                                        fill: 1,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "N 1234 SYBAU",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// ICON + GARIS
                                  Column(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE45A1F),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_upward,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),

                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        // color: Colors.grey,
                                        child: Icon(Symbols.more_vert),
                                      ),

                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(width: 14),

                                  /// TEXT AREA
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "SMK Negeri 4 Malang",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                        const SizedBox(height: 15),

                                        const SizedBox(height: 18),

                                        Text(
                                          "Rujak Cingur Penyet",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Divider(color: Colors.grey.shade400),

                              const SizedBox(height: 15),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: const Color(
                                          0xFFE04D04,
                                        ),
                                        radius: 20,
                                        child: Icon(
                                          Icons.money_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Text(
                                        "Tunai",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "Rp. 12.000",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ORDER BUTTON
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              Get.toNamed(Routes.PESANDRIVER);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE45A1F),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Batalkan Pesanan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// reusable icon circle
  Widget _circleIcon(IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD46A2E)),
      ),
      child: Icon(icon, color: const Color(0xFFD46A2E), fill: 1),
    );
  }
}
