import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:cakli_driver/app/routes/app_pages.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset('assets/images/profil/ilustrasi2.png'),
                  ),
                ),

                Positioned(
                  bottom: -60,
                  left: 20,
                  right: 20,
                  child: ProfileCardView(),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 55),

                  DriverSection(),
                  SizedBox(height: 20),

                  TextMenuLainya(),
                  SizedBox(height: 20),
                  MenuLainya(),

                  SizedBox(height: 20),
                  MenuLainyaDanger(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String userId;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}

class ProfileCardView extends GetView<ProfilController> {
  const ProfileCardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Register controller jika belum
    Get.put(ProfilController());

    return Column(children: [_UserInfoCard()]);
  }
}

// ─────────────────────────────────────────
// User Info Card
// ─────────────────────────────────────────
class _UserInfoCard extends GetView<ProfilController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Obx(() {
                final user = controller.user.value;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar
                    _AvatarWidget(initials: user.initials),

                    const SizedBox(width: 16),

                    // User details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF757575),
                              height: 1.4,
                            ),
                          ),
                          Text(
                            user.phone,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF757575),
                              height: 1.4,
                            ),
                          ),
                          Text(
                            user.userId,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF757575),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Edit button
                    _EditButton(onTap: controller.onEditTapped),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// Avatar Widget
// ─────────────────────────────────────────
class _AvatarWidget extends StatelessWidget {
  final String initials;

  const _AvatarWidget({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: Color(0xFFD84315),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x33D84315),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// Edit Button
// ─────────────────────────────────────────
class _EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EditButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.edit, size: 18, color: Color(0xFF424242)),
      ),
    );
  }
}

class DriverSection extends StatelessWidget {
  const DriverSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          // layar kecil
          return Column(
            children: [
              SaldoPoin(),
              SizedBox(height: 10),
              DriverPoin(),
              SizedBox(height: 10),
              RatingCustomer(),
            ],
          );
        } else {
          // layar normal
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: SaldoPoin()),
                  SizedBox(width: 10),
                  Expanded(child: DriverPoin()),
                ],
              ),
              SizedBox(height: 10),
              RatingCustomer(),
            ],
          );
        }
      },
    );
  }
}

class SaldoPoin extends StatelessWidget {
  const SaldoPoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB1B1B1), width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFFE04D04),
            child: Icon(Symbols.attach_money, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saldo Poin',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFE04D04),
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                '10.000',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DriverPoin extends StatelessWidget {
  const DriverPoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB1B1B1), width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/icon/poin.png', width: 35, height: 35),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Poin Driver',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFE04D04),
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                '10.000',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RatingCustomer extends StatelessWidget {
  const RatingCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.RIWAYAT);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFB1B1B1), width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.grey, size: 24),
                SizedBox(width: 5),
                Text(
                  'Penilaian dari customer',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            Icon(Symbols.arrow_forward_ios, size: 24, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class TextMenuLainya extends StatelessWidget {
  const TextMenuLainya({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Menu Lainnya',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class MenuLainya extends StatelessWidget {
  const MenuLainya({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Symbols.settings, fill: 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pengaturan'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.PENGATURAN);
            },
          ),
          ListTile(
            leading: const Icon(Symbols.qr_code, fill: 1, weight: 900),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kode QR'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {
              // Aksi saat menu Notifikasi ditekan
            },
          ),

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF515151),
              radius: 13,
              child: Icon(Symbols.priority_high, color: Colors.white, size: 13),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status akun & sanksi'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF515151),
              radius: 13,
              child: Icon(Symbols.check, color: Colors.white, size: 13),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cek aplikasi'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Symbols.article, fill: 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Penyerahan dokumen'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {
              // Aksi saat menu Privasi ditekan
            },
          ),

          ListTile(
            leading: const Icon(Icons.people_alt_rounded, fill: 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ajak teman jadi mitra'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.person, fill: 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Perjanjian Kemitraan'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.sms, fill: 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Buat janji'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF515151),
              radius: 13,
              child: Icon(Symbols.question_mark, color: Colors.white, size: 13),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bantuan'),
                Icon(
                  Symbols.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                  weight: 900,
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class MenuLainyaDanger extends StatelessWidget {
  const MenuLainyaDanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.redAccent),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Symbols.logout,
              color: Colors.redAccent,
              fill: 1,
              weight: 900,
            ),
            title: const Text(
              'Keluar',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              // Aksi saat menu Privasi ditekan
            },
          ),
        ],
      ),
    );
  }
}
