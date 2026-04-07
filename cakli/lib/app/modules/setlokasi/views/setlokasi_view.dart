import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cakli/app/routes/app_pages.dart';
import '../controllers/setlokasi_controller.dart';

class SetlokasiView extends GetView<SetlokasiController> {
  const SetlokasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Kembali'),
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
                    context: context,
                    icon: Symbols.map,
                    iconColor: Colors.blue,
                    text: "Pilih lewat peta",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRoundedButton(
                    context: context,
                    icon: Symbols.my_location,
                    iconColor: const Color(0xFFD46A2E),
                    text: "Lokasimu sekarang",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
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
                LocationHeader(
                  title: "SMK Negeri 8 Malang",
                  address: "Jl. Teluk Pacitan, Arjosari, Blimbing",
                  highlight: false,
                  onTap: () {
                    Get.toNamed(Routes.PESANALAMAT);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedButton({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Container(
      // height: 50,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.001, vertical: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, fill: 1),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
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
                  fontWeight: FontWeight.w700,
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
                  pickup,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                Divider(color: Colors.grey.shade300),

                const SizedBox(height: 8),

                Text(
                  destination,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
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
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: highlight ? const Color(0xFFE45A1F) : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            const Divider(thickness: 1, color: Colors.grey, height: 0),
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
        decoration: BoxDecoration(color: const Color(0xFFF7F7F7)),
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 13,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Row(
                      children: [
                        Icon(icon, color: Colors.grey, fill: 1, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
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
