import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:material_symbols_icons/symbols.dart';

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
            children: [
              /// CaPay Button
              GestureDetector(
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

                    const Text(
                      "CaPay",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),

              /// Voucher Button
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.VOUCHER);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
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
                        child: const Icon(
                          Icons.percent,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(width: 8),

                      Text(
                        "Voucher",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Order Button
          /// Order Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () {
                Get.toNamed(Routes.PESANDRIVER);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE45A1F),
                  borderRadius: BorderRadius.circular(40), // lebih pill
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// TEXT KIRI
                    const Text(
                      "Cari driver",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    /// PRICE + ICON
                    Row(
                      children: [
                        const Text(
                          "Rp10.000",
                          style: TextStyle(
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
          ),
        ],
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

              const Text(
                "Metode Pembayaran",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

                title: const Text(
                  "Capay",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: const Text("Saldo: Rp 50.000"),

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

                title: const Text(
                  "Cash",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: const Text("Gunakan Uang Tunai"),

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

                title: const Text(
                  "Qris",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: const Text("Scar QR Qris Pada Driver"),

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
