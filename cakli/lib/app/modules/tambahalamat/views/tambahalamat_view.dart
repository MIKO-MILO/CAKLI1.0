import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:material_symbols_icons/symbols.dart';
import 'package:get/get.dart';
import 'package:cakli/app/routes/app_pages.dart';

import '../controllers/tambahalamat_controller.dart';

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

class TambahalamatView extends GetView<TambahalamatController> {
  const TambahalamatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      body: Stack(
        children: [
          SafeArea(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(-7.983908, 112.621391),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.cakli.app',
                  tileProvider: NetworkTileProvider(
                    httpClient: _HeaderedClient({
                      'User-Agent': 'com.cakli.app/1.0',
                    }),
                  ),
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tambah Alamat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),

                  SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.CARIALAMAT,
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

                  SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ICON + TEXT BLOCK
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xFFD46A2E),
                              size: 28,
                            ),

                            const SizedBox(width: 12),

                            /// BAGIAN TEXT (JUDUL + DESKRIPSI)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SMKN 4 Malang",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    "Jl. Tanimbar No. 22 Lorem Ipsum dolor sit Amet "
                                    "blablaskdkjieygdyt Curabitur ut finibus metus, "
                                    "aliquet tempus sem.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// TOMBOL TAMBAH PATOKAN
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 70,
                              ),
                              hintText: "Tambah Patokan",
                              prefixIcon: Icon(
                                Symbols.personal_places,
                                fill: 1,
                                color: Color(0xFFF36200),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),

                    child: TextFormField(
                      initialValue: "mimimimimi@gmail.com",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text("*", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.EDITALAMAT);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE04D04),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.32,
            left: 20,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 4,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
