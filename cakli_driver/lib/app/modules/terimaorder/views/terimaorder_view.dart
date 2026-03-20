import 'package:cakli_driver/app/modules/antarorder/views/antarorder_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../controllers/terimaorder_controller.dart';

class TerimaorderView extends GetView<TerimaorderController> {
  const TerimaorderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terima Order'), centerTitle: true),
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
      initialChildSize: 0.7,
      minChildSize: 0.35,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              SheetHandle(),
              PopupHeader(),
              PopupUser(),
              TimelineSection(),
              Popupslider(),
            ],
          ),
        );
      },
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

class PopupHeader extends StatelessWidget {
  const PopupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // TITLE (center beneran)
          Center(
            child: Text(
              'Jemput Penumpang',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),

          // BACK BUTTON (kiri)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Symbols.arrow_back_ios, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopupUser extends StatelessWidget {
  const PopupUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                        'Aulia Sukma R.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 2),

                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text('4.7', style: TextStyle(fontSize: 14)),
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
                    onPressed: () {},
                    icon: Icon(Icons.call, color: Color(0xFFE04D04)),
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

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔴 Garis & titik
          Column(
            children: [
              // titik atas
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Color(0xFFE04D04),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              // garis
              Container(width: 2, height: 75, color: Color(0xFFE04D04)),

              // titik bawah
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Color(0xFFE04D04).withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Color(0xFFE04D04),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 12),

          // 📍 Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "11.25am",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "Gerbang Samping, SMK Negeri 4 Malang, Kecamatan Klojen",
                  style: TextStyle(fontSize: 12),
                ),

                SizedBox(height: 40),

                Text(
                  "11.45am",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "Jl. Gadang gg 12 no 18, Gadang",
                  style: TextStyle(fontSize: 12),
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
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 30),
      child: SlideAction(
        text: "Jemput Penumpang",
        textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
