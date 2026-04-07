import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:get/get.dart';

import '../controllers/pesan_controller.dart';

class PesanView extends GetView<PesanController> {
  const PesanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
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
            children: [
              /// CaPay Button
              const PaymentButton(),
              /// Voucher Button
              const VoucherButton(),
            ],
          ),

          const SizedBox(height: 16),

          const _BottomActionBarButton(),
        ],
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const Payment(),
        );
      },
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE45A1F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Text(
            "CaPay",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 6),

          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class VoucherButton extends StatelessWidget {
  const VoucherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.VOUCHER);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFE45A1F),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.percent, size: 18, color: Colors.white),
            ),

            SizedBox(width: 8),

            Text(
              "Voucher",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
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
          Get.toNamed(Routes.PESANDRIVER);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFE04D04),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// TEXT KIRI
              Text(
                "Cari driver",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),

              /// PRICE + ICON
              Row(
                children: [
                  Text(
                    "Rp10.000",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Color(0xFFE45A1F),
                    ),
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

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.43,
      minChildSize: 0.4,
      maxChildSize: 0.43,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // garis atas
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Text(
                "Metode Pembayaran",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),

              // ITEM 1
              ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD75A1A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                ),

                title: Text(
                  "Capay",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),

                subtitle: Text("Saldo: Rp 50.000"),

                trailing: CustomRadio(
                  selected: groupValue == 1,
                  onTap: () {
                    setState(() {
                      groupValue = 1;
                    });
                  },
                ),

                onTap: () {
                  setState(() {
                    groupValue = 1;
                  });
                },
              ),

              const SizedBox(height: 10),

              // ITEM 2
              ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD75A1A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Symbols.money_bag,
                    color: Colors.white,
                    fill: 1,
                  ),
                ),

                title: Text(
                  "Cash",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),

                subtitle: Text("Gunakan Uang Tunai"),

                trailing: CustomRadio(
                  selected: groupValue == 2,
                  onTap: () {
                    setState(() {
                      groupValue = 2;
                    });
                  },
                ),

                onTap: () {
                  setState(() {
                    groupValue = 1;
                  });
                },
              ),

              const SizedBox(height: 10),

              // ITEM 3
              ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD75A1A),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/images/qris.png",
                    width: 24,
                    height: 24,
                  ),
                ),

                title: Text(
                  "Qris",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),

                subtitle: Text("Scar QR Qris Pada Driver"),

                trailing: CustomRadio(
                  selected: groupValue == 3,
                  onTap: () {
                    setState(() {
                      groupValue = 3;
                    });
                  },
                ),

                onTap: () {
                  setState(() {
                    groupValue = 3;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomRadio extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const CustomRadio({super.key, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD75A1A), width: 2),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: selected
                ? Center(
                    child: Container(
                      key: const ValueKey("dot"),
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD75A1A),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
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
