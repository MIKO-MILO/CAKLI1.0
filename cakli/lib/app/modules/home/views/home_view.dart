import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;

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
                  child: Image.asset(
                    'assets/images/home/User.png',
                    width: 100,
                    height: 100,
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
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (ctx) {
                                final textCtrl = TextEditingController(
                                  text: controller.searchQuery.value,
                                );
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(ctx).viewInsets.bottom,
                                  ),
                                  child: SafeArea(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: TextField(
                                            controller: textCtrl,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              hintText: 'Cari lokasi...',
                                              filled: true,
                                              fillColor: Colors.grey.shade200,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                            ),
                                            onChanged: controller.searchPlaces,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(ctx).size.height *
                                              0.5,
                                          child: Obx(
                                            () => ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemCount: controller
                                                  .searchResults.length,
                                              separatorBuilder:
                                                  (context, index) => Divider(
                                                height: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              itemBuilder: (context, index) {
                                                final item = controller
                                                    .searchResults[index];
                                                return ListTile(
                                                  leading: const Icon(
                                                      Icons.place_outlined),
                                                  title: Text(
                                                    item['title']
                                                            ?.toString() ??
                                                        '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  onTap: () {
                                                    controller
                                                        .selectPlace(item);
                                                    Navigator.pop(ctx);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: const [
                                CircleAvatar(
                                  radius: 11,
                                  backgroundColor: Colors.orange,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    "Cari lokasi tujuan",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Icon(Icons.search, color: Colors.grey),
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
                    separatorBuilder: (_, index) => Divider(
                      height: 20,
                      color: Colors.grey.shade400,
                    ),
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}