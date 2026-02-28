import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../controllers/pesan_controller.dart';

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

class PesanView extends GetView<PesanController> {
  const PesanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(title: const Text('PesanView')),
      body: Stack(
        children: [
          /// 1️⃣ MAP BACKGROUND
          Positioned.fill(
            child: Container(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(-7.9553, 112.6280),
                  initialZoom: 9.2,
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
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () async {
                          final url = Uri.parse(
                            'https://openstreetmap.org/copyright',
                          );
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// 2️⃣ TOP PICKUP CARD
          Positioned(child: _TopLocationCard()),

          /// 3️⃣ BOTTOM ACTION AREA
          Positioned(bottom: 0, left: 0, right: 0, child: _BottomActionBar()),
        ],
      ),
    );
  }
}

class _TopLocationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RouteLocationCard(
            pickup: "SMK Negeri 4 Malang",
            destination: "JL. Nasional Gg.6",
          ),
        ],
      ),
    );
  }
}

class RouteLocationCard extends StatelessWidget {
  final String pickup;
  final String destination;

  const RouteLocationCard({
    super.key,
    required this.pickup,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
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
                width: 2,
                height: 24,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey,
              ),

              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.circle, size: 10, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(width: 14),

          /// TEXT AREA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pickup,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                Divider(color: Colors.grey.shade300),

                const SizedBox(height: 8),

                Text(
                  destination,
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
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Payment + Voucher
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_SmallButton("GoPay"), _SmallButton("Voucher")],
          ),

          const SizedBox(height: 16),

          /// Order Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE45A1F),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 16),
                Text(
                  "Cari driver",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    "Rp10.000",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final String title;

  const _SmallButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
