import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PesandriverView extends StatelessWidget {
  const PesandriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: const CustomAppBar(title: 'Kembali'),
      body: Stack(
        children: [
          /// ================= MAP =================
          const MapView(),

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
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TopBar(),

                        /// ================= HEADER =================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: HeaderText(),
                        ),

                        /// CARD DRIVER
                        const DriverCard(),

                        const SizedBox(height: 15),

                        /// CARD INFO
                        const InfoCard(),

                        const SizedBox(height: 20),

                        const CancelButton(),
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

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ===== TEXT KIRI =====
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pengemudi dalam",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.3,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              "perjalanan",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.3,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        /// ===== TEXT KANAN =====
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Perkiraan datang",
              style: GoogleFonts.poppins(
                fontSize: 12,
                height: 1,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              "dalam",
              style: GoogleFonts.poppins(
                fontSize: 12,
                height: 1,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              "10 menit",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130,
        height: 5,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  const DriverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const SizedBox(height: 0),
          DriverCardTop(),
          const SizedBox(height: 20),
          DriverCardNameRating(),
          const SizedBox(height: 3),
          DriverCardVehichle(),

          Row(children: [const SizedBox(width: 10)]),
        ],
      ),
    );
  }
}

class DriverCardTop extends StatelessWidget {
  const DriverCardTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [DriverCardImageProfil(), DriverCardButton()],
    );
  }
}

class DriverCardImageProfil extends StatelessWidget {
  const DriverCardImageProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/pesandriver/profile.png', width: 50),
        Container(
          width: 55,
          height: 55,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset('assets/images/aktivitas/becak.png'),
        ),
      ],
    );
  }
}

class DriverCardButton extends StatelessWidget {
  const DriverCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              border: Border.all(color: Color(0xFFD46A2E)),
            ),
            child: Icon(Symbols.chat, color: Color(0xFFD46A2E), fill: 1),
          ),
        ),

        const SizedBox(width: 10),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFD46A2E)),
          ),
          child: Icon(Symbols.call, color: Color(0xFFD46A2E), fill: 1),
        ),
      ],
    );
  }
}

class DriverCardNameRating extends StatelessWidget {
  const DriverCardNameRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [DriverCardName(), DriverCardRating()]);
  }
}

class DriverCardRating extends StatelessWidget {
  const DriverCardRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class DriverCardName extends StatelessWidget {
  const DriverCardName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Alenxander Fabio",
      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}

class DriverCardVehichle extends StatelessWidget {
  const DriverCardVehichle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [DriverVehichleName(), DriverCardPlate()],
    );
  }
}

class DriverVehichleName extends StatelessWidget {
  const DriverVehichleName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Becak Honda A70s",
      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}

class DriverCardPlate extends StatelessWidget {
  const DriverCardPlate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Symbols.circle, size: 15, fill: 1, color: Colors.green),
        const SizedBox(width: 5),
        Text(
          "N 1234 SYBAU",
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          AdressView(),
          const SizedBox(height: 15),

          Divider(color: Colors.grey.shade400),

          const SizedBox(height: 15),

          MoneyView(),
        ],
      ),
    );
  }
}

class AdressView extends StatelessWidget {
  const AdressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              margin: const EdgeInsets.symmetric(vertical: 4),
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
                "SMK Negeri 4 Malang",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 15),

              const SizedBox(height: 18),

              Text(
                "Rujak Cingur Penyet",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MoneyView extends StatelessWidget {
  const MoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE04D04),
              radius: 20,
              child: Icon(Icons.money_rounded, size: 20, color: Colors.white),
            ),

            const SizedBox(width: 10),

            Text(
              "Tunai",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        Text(
          "Rp. 12.000",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.PESANALAMAT);
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
          'Batalkan Order',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}