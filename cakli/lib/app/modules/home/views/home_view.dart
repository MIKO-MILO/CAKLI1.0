import 'package:cakli/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:material_symbols_icons/symbols.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class _HeaderedClient extends http.BaseClient {
  final Map<String, String> headers;
  final http.Client _inner = http.Client();

  _HeaderedClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headers);
    return _inner.send(request);
  }
}

class HomeView extends GetView<HomeController> {
  Widget _buildActionBox({
    required String text,
    required String asset,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(asset, width: 22, height: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sesuaikan nilai ini agar container MAP naik ke atas header
    const double overlapOffset = 100.0;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ================= HEADER =================
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/home/ilustrasi.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width * 0.80,
                  bottom: MediaQuery.of(context).size.height * 0.47,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SETTING);
                    },
                    child: Image.asset(
                      'assets/images/home/User.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),

                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Mau ke mana, Aul ?',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 245,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Jl Gadang omah e uztazah',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // ================= CONTAINER MAP (overlap ke header) =================
                Positioned(
                  bottom: -overlapOffset,
                  left: 30,
                  right: 30,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // MAP
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Obx(() {
                              final c = controller.center.value;
                              return FlutterMap(
                                key: ValueKey('${c.latitude},${c.longitude}'),
                                options: MapOptions(
                                  initialCenter: c,
                                  initialZoom: 12.5,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.cakli.app',
                                    tileProvider: NetworkTileProvider(
                                      httpClient: _HeaderedClient({
                                        'User-Agent': 'com.cakli.app/1.0',
                                      }),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // SEARCH BOX
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.SETLOKASI,
                            ); // atau Get.to(PageTujuan());
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Symbols.circle_circle,
                                  fill: 1,
                                  color: Color(0xFFF36200),
                                ),
                                const SizedBox(width: 12),

                                const Expanded(
                                  child: Text(
                                    "Cari lokasi tujuan",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                const Icon(Symbols.search),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ACTION BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionBox(
                                text: "Simpan Rumah",
                                asset: 'assets/images/icon/lokasi1.png',
                                onTap: () {
                                  Get.snackbar(
                                    'Simpan Rumah',
                                    'Lokasi rumah disimpan',
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildActionBox(
                                text: "Simpan Kantor",
                                asset: 'assets/images/icon/lokasi1.png',
                                onTap: () {
                                  Get.snackbar(
                                    'Simpan Kantor',
                                    'Lokasi kantor disimpan',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Beri ruang untuk container MAP yang overlap
            SizedBox(height: overlapOffset + 16),

            // ================= LIST CONTAINER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Obx(
                  () => ListView.separated(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.locations.length,
                    separatorBuilder: (_, index) =>
                        Divider(height: 20, color: Colors.grey.shade400),
                    itemBuilder: (context, index) {
                      final item = controller.locations[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/icon/jam.png',
                              width: 30,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["title"]!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    item["subtitle"]!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/images/icon/lokasi1.png',
                              width: 24,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
