import 'package:cakli_driver/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapView(),
          // HeaderView(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Header(),
          ),

          // Navigation
          Positioned(bottom: 20, left: 0, right: 0, child: Navigation()),
        ],
      ),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar + Status
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE04D04), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.PROFIL),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/home/profile.png'),
              ),
            ),
          ),

          StatusButton(),

          // Tombol Power
          GestureDetector(
            onTap: () => showStatusModal(context),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusButton extends StatefulWidget {
  const StatusButton({super.key});

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOnline = !isOnline; // toggle
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Text(
          isOnline ? "Online" : "Offline",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isOnline ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          NavItem(
            icon: Icons.home,
            label: "Beranda",
            active: true,
            route: Routes.HOME,
          ),
          NavItem(
            icon: Icons.account_balance_wallet,
            label: "Pendapatan",
            route: Routes.PENDAPATAN,
          ),
          NavItem(icon: Icons.mail, label: "Pesan", route: Routes.LISTCHAT),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final String route;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFE04D04);
    const inactiveColor = Color(0xFFBDBDBD);

    return GestureDetector(
      onTap: () => route.toNamed(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top indicator bar
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: active ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              boxShadow: context.isDarkMode
                  ? active
                        ? null
                        : [
                            BoxShadow(
                              color: Colors.deepOrange,
                              blurRadius: 15,
                              offset: const Offset(10, 10),
                            ),
                          ]
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, color: active ? activeColor : inactiveColor, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: active ? activeColor : inactiveColor,
              fontSize: 12,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

extension on String {
  void toNamed(String get) => Get.toNamed(get);
}

void showStatusModal(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'status_modal',
    barrierColor: Colors.black.withOpacity(0.5), // Map tetap terlihat
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, _, _) => const StatusModal(),
    transitionBuilder: (_, animation, _, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

class StatusModal extends StatefulWidget {
  const StatusModal({super.key});

  @override
  State<StatusModal> createState() => _StatusModalState();
}

class _StatusModalState extends State<StatusModal> {
  bool _autoBid = true;

  static const _orange = Color(0xFFE04D04);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.1), // sedikit di atas tengah
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Card utama ──────────────────────────────────
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Status pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Offline',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.keyboard_arrow_down, size: 22),
                    ],
                  ),

                  Divider(
                    color: const Color.fromARGB(255, 214, 214, 214),
                    thickness: 1,
                    height: 20,
                  ),

                  const SizedBox(height: 16),

                  // Poin hari ini
                  Text(
                    'Poin hari ini',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/home/medal_icon.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '750',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '5 dari 5 trip selesai',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 16),

                  // Stats row
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _StatItem(
                            label: 'Penerimaan bid',
                            value: '100%',
                            icon: Icons.check_circle,
                            iconColor: const Color(0xFFE04D04),
                          ),
                          const SizedBox(width: 24),
                          _StatItem(
                            label: 'Penyelesaian trip',
                            value: '100%',
                            icon: Icons.upload_rounded,
                            iconColor: _orange,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(height: 1),

                  // Autobid toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Autobid',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Switch(
                          value: _autoBid,
                          onChanged: (v) => setState(() => _autoBid = v),
                          activeThumbColor: _orange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Tombol tutup ─────────────────────────────────
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.close, size: 26, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget helper untuk stat item ───────────────────────────
class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.info_outline, size: 14, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
