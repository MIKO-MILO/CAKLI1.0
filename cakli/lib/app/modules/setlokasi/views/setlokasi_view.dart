import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cakli/app/routes/app_pages.dart';
import '../controllers/setlokasi_controller.dart';

class SetlokasiView extends GetView<SetlokasiController> {
  const SetlokasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        title: const Text(
          'Set Lokasi Jemput',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xFFEBE8E8),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const RouteLocationCard(
                  pickup: "SMK Negeri 4 Malang",
                  destination: "JL. Nasional Gg.6",
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _buildRoundedButton(
                    icon: Symbols.map,
                    iconColor: Colors.blue,
                    text: "Pilih lewat peta",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRoundedButton(
                    icon: Symbols.my_location,
                    iconColor: const Color(0xFFD46A2E),
                    text: "Lokasimu sekarang",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Divider(thickness: 1, color: Colors.grey, height: 0),

          Expanded(
            child: ListView(
              children: [
                LocationHeader(
                  title: "SMK Negeri 4 Malang",
                  address: "Jl. Tanimbar No. 22, Kasin, Klojen, Malang",
                  highlight: true,
                  onTap: () {
                    Get.toNamed(Routes.PESANALAMAT);
                  },
                ),
                LocationOption(
                  title: "Gerbang Sekolah",
                  subtitle: "Kamu pernah di sini",
                  icon: Icons.refresh,
                  onTap: () {
                    Get.toNamed(Routes.PESANALAMAT);
                  },
                ),
                LocationOption(
                  title: "Gerbang Samping",
                  subtitle: "Paling dekat",
                  icon: Icons.location_on,
                  onTap: () {
                    Get.toNamed(Routes.PESANALAMAT);
                  },
                ),
                const Divider(thickness: 1, height: 0),
                LocationHeader(
                  title: "SMK Negeri 8 Malang",
                  address: "Jl. Teluk Pacitan, Arjosari, Blimbing",
                  highlight: false,
                  onTap: () {
                    Get.toNamed(Routes.PESANALAMAT);
                  },
                ),
                const Divider(thickness: 1, height: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedButton({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, fill: 1),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// =============================
/// WIDGET ROUTE CARD
/// =============================
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

class LocationHeader extends StatelessWidget {
  final String title;
  final String address;
  final bool highlight;
  final VoidCallback? onTap;

  const LocationHeader({
    super.key,
    required this.title,
    required this.address,
    required this.highlight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.access_time, color: Colors.grey),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      color: highlight ? const Color(0xFFE45A1F) : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const LocationOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Symbols.bookmark_border, color: Colors.grey, fill: 1),
          ],
        ),
      ),
    );
  }
}
