import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cakli/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/pesanalamat_controller.dart';

class PesanalamatView extends GetView<PesanalamatController> {
  const PesanalamatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: const Color(0xFFEBE8E8),
        appBar: CustomAppBar(title: 'Kembali'),
        body: Stack(
          children: [
            /// 1️⃣ MAP BACKGROUND
            MapView(),

            /// 2️⃣ TOP PICKUP CARD
            Positioned(child: _TopLocationCard()),

            /// 3️⃣ BOTTOM ACTION AREA
            Positioned(bottom: 0, left: 0, right: 0, child: _BottomActionBar()),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
        ),
        child: Row(
          children: [
            // Tombol Back
            IconButton(
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
            ),
            // Title
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
            ),
            // Actions (opsional)
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _TopLocationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RouteLocationCardLogo(),
          SizedBox(width: 8),
          RouteLocationCardText(pickup: pickup, destination: destination),
        ],
      ),
    );
  }
}

class RouteLocationCardLogo extends StatelessWidget {
  const RouteLocationCardLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFE45A1F),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_upward, size: 14, color: Colors.white),
        ),

        Icon(Symbols.more_vert),

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
    );
  }
}

class RouteLocationCardText extends StatelessWidget {
  const RouteLocationCardText({
    super.key,
    required this.pickup,
    required this.destination,
  });

  final String pickup;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pickup,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 8),

          Text(
            destination,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.fromLTRB(16, 35, 16, 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Payment + Voucher
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BottomActionBarTextCurrentLocation(),

                const SizedBox(height: 20),

                _BottomActionBarTextLocation(),

                const SizedBox(height: 20),

                _BottomActionBarTextAdress(),

                const SizedBox(height: 20),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Order Button
          _BottomActionBarButton(),
        ],
      ),
    );
  }
}

class _BottomActionBarTextAdress extends StatelessWidget {
  const _BottomActionBarTextAdress();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Jl. Tanimbar No.22, Kasin, Kec. Klojen, Malang, Jawa Timur 65117",
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    );
  }
}

class _BottomActionBarTextLocation extends StatelessWidget {
  const _BottomActionBarTextLocation();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "SMK NEGERI 4 MALANG",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SETLOKASI);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                color: const Color(0xFFE04D04),
                width: 1,
              ),
            ),
            child: Text(
              "Edit",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomActionBarTextCurrentLocation extends StatelessWidget {
  const _BottomActionBarTextCurrentLocation();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your Current Location",
      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}

class _BottomActionBarButton extends StatelessWidget {
  const _BottomActionBarButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.PESAN);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFE04D04),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Selanjutnya',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
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
              httpClient: _HeaderedClient({'User-Agent': 'com.cakli.app/1.0'}),
            ),
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () async {
                  final url = Uri.parse('https://openstreetmap.org/copyright');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
            ],
          ),
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
