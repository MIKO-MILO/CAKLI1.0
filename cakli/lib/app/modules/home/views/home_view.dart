import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  Widget _buildButton(String text) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/home/ilustrasi.svg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),

            Positioned(
              top: 200, // atur sesuai kebutuhan
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Mau ke mana, Aul ?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 245, // atur sesuai kebutuhan
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Jl Gadang omah e uztazah',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.33,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: double.infinity,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(51.509364, -0.128928),
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

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/icon/lokasi1.png',
                                ),
                                width: 24,
                              ),
                              const SizedBox(width: 10),
                              _buildButton("Simpan Rumah"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/icon/lokasi1.png',
                                ),
                                width: 24,
                              ),
                              const SizedBox(width: 10),
                              _buildButton("Simpan Kantor"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: 30,
              height: 3,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
