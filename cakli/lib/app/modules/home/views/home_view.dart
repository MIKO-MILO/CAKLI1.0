import 'package:cakli/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:material_symbols_icons/symbols.dart';

import 'package:get/get.dart';
import 'package:cakli/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEBEB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              ImageHeader(),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top * 3.5,
                ),
                child: TextHeader(),
              ),

              Column(
                children: [
                  SizedBox(height: 250),
                  SizedBox(height: 20),
                  ContainerMap(),
                  SizedBox(height: 5),
                  ListLocation(),
                ],
              ),

              Positioned(
                top: MediaQuery.of(context).padding.top * 0.5,
                right: 15,
                child: Profile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SETTING);
      },
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/home/User.png'),
        radius: 18,
      ),
    );
  }
}

class TextHeader extends StatelessWidget {
  const TextHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
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

        Center(
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
      ],
    );
  }
}

class ImageHeader extends StatelessWidget {
  const ImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/home/ilustrasi.png',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}

class ContainerMap extends StatelessWidget {
  const ContainerMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
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
      child: Column(
        children: [
          const MapView(),
          const SizedBox(height: 20),
          const SearchLocation(),
          const SizedBox(height: 20),
          const ActionButton(),
        ],
      ),
    );
  }
}

class MapView extends GetView<HomeController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFCFCFCF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Obx(
          () => FlutterMap(
            options: MapOptions(
              initialCenter: controller.center.value,
              initialZoom: 13.0,
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
      ),
    );
  }
}

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SETLOKASI);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
            const Icon(
              Symbols.circle_circle,
              fill: 1,
              color: Color(0xFFF36200),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Cari lokasi tujuan",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            const Icon(Symbols.search),
          ],
        ),
      ),
    );
  }
}

class ListLocation extends GetView<HomeController> {
  const ListLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
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
                    Image.asset('assets/images/icon/jam.png', width: 30),
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
                    Image.asset('assets/images/icon/lokasi1.png', width: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [ActionButtonLeft(), SizedBox(width: 20), ActionButtonRight()],
    );
  }
}

class ActionButtonLeft extends StatelessWidget {
  const ActionButtonLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _BuildActionBox(
        text: "Simpan Rumah",
        asset: 'assets/images/icon/lokasi1.png',
        onTap: () {
          Get.snackbar('Simpan Rumah', 'Lokasi rumah disimpan');
        },
      ),
    );
  }
}

class ActionButtonRight extends StatelessWidget {
  const ActionButtonRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _BuildActionBox(
        text: "Simpan Kantor",
        asset: 'assets/images/icon/lokasi1.png',
        onTap: () {
          Get.snackbar('Simpan Kantor', 'Lokasi kantor disimpan');
        },
      ),
    );
  }
}

class _BuildActionBox extends StatelessWidget {
  const _BuildActionBox({
    required this.text,
    required this.asset,
    required this.onTap,
  });

  final String text;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(asset, width: 20, height: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
