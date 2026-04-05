import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:cakli_driver/app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

import '../controllers/antarorder_controller.dart';

class AntarorderView extends GetView<AntarorderController> {
  const AntarorderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AntarorderView'), centerTitle: true),
      body: Stack(
        children: [
          SafeArea(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(-7.9553, 112.6280),
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

          PopupMenu(),
        ],
      ),
    );
  }
}

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

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.15,
      maxChildSize: 0.55,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              SheetHandle(),
              TujuanPengantaranView(),
              PopupUser(),
              Popupslider(),
            ],
          ),
        );
      },
    );
  }
}

class TujuanPengantaranView extends StatelessWidget {
  const TujuanPengantaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Indicator
          Column(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(0xFFFFDECE),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4AB87),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Color(0xFFE04D04),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tujuan Pengantaran',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  'Gerbang Samping, SMK Negeri 4 Malang',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
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

class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: 140,
        height: 5,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E4E4),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class PopupUser extends StatelessWidget {
  const PopupUser({super.key});

  String singkatNama(String nama) {
    List<String> parts = nama.trim().split(' ');

    if (parts.length < 3) return nama;

    return '${parts[0]} ${parts[1]} ${parts.last[0].toUpperCase()}.';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE04D04),
                    ),

                    child: Icon(
                      Icons.access_time_filled_rounded,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '14 Menit',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(width: 16),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE04D04),
                    ),

                    child: Icon(
                      Symbols.money,
                      color: Colors.white,
                      size: 10,
                      fill: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Rp 15.000',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Divider(height: 1, color: Colors.grey[300]),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                // 🔴 Avatar
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFE65100),
                  child: Text(
                    'AS',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),

                SizedBox(width: 16),

                // 🧾 Nama + Rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        singkatNama('Aulia Sukma Ramadani'),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 2),

                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text('4.7', style: GoogleFonts.poppins(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),

                // 📞 Call Button
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.CHAT);
                    },
                    icon: Icon(Icons.chat, color: Color(0xFFE04D04)),
                  ),
                ),

                SizedBox(width: 10),

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.call, color: Color(0xFFE04D04), fill: 1),
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

class Popupslider extends StatelessWidget {
  const Popupslider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: SlideAction(
        text: "Penumpang Sampai Tujuan",
        textStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        outerColor: Color(0xFFE04D04),
        innerColor: Colors.white,
        elevation: 0,
        onSubmit: () {
          Get.to(() => AntarorderView());
          return null; // pindah halaman
        },
      ),
    );
  }
}
