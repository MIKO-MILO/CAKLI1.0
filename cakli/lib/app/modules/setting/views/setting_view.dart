import 'package:cakli/app/routes/app_pages.dart';
import 'package:cakli/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:get/get.dart';
import '../controllers/setting_controller.dart';
import '../../../../services/api_service.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ImageHeader(),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150),
                  ProfileTop(),
                  SizedBox(height: 20),
                  TextPengaturan(),
                  SizedBox(height: 20),
                  SettingWhiteView(),
                  SizedBox(height: 20),
                  SettingRedView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageHeader extends StatelessWidget {
  const ImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/setting/ilustrasi.png',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}

class ProfileTop extends StatelessWidget {
  const ProfileTop({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return FutureBuilder<User>(
      future: apiService.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data as User;

          return Container(
            padding: const EdgeInsets.all(20),
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
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileImage(imageUrl: user.imageUrl),
                    const SizedBox(width: 20),
                    TextProfile(
                      name: user.name,
                      email: user.email,
                      phone: user.phone,
                    ),
                  ],
                ),
                ButtonProfile(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // Jika imageUrl adalah URL internet (dimulai dengan http), gunakan Image.network
    if (imageUrl.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback jika gambar gagal dimuat
            return Image.asset(
              'assets/images/setting/profile.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            );
          },
        ),
      );
    }

    // Jika bukan URL (misal asset lokal), gunakan Image.asset
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
    );
  }
}

class TextProfile extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const TextProfile({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(email),
        Text(phone),
      ],
    );
  }
}

class ButtonProfile extends StatelessWidget {
  const ButtonProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.EDITPROFILE);
      },
      child: const Icon(Icons.edit),
    );
  }
}

class TextPengaturan extends StatelessWidget {
  const TextPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Pengaturan',
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }
}

class SettingWhiteView extends StatelessWidget {
  const SettingWhiteView({super.key});

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
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: Text('Ganti Email'),
            onTap: () {
              Get.toNamed(Routes.EDITEMAIL);
            },
          ),
          ListTile(
            leading: const Icon(Symbols.credit_card, fill: 1),
            title: Text('Ganti PIN E-Wallet'),
            onTap: () {
              // Aksi saat menu Notifikasi ditekan
              Get.toNamed(Routes.EDITPIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text('Alamat Tersimpan'),
            onTap: () {
              Get.toNamed(Routes.EDITALAMAT);
            },
          ),

          ListTile(
            leading: const Icon(Symbols.history, fill: 1, weight: 900),
            title: Text('Riwayat'),
            onTap: () {
              Get.toNamed(Routes.AKTIVITAS);
            },
          ),

          ListTile(
            leading: const Icon(Symbols.star, fill: 1),
            title: Text('Beri Rating'),
            onTap: () {
              // Aksi saat menu Privasi ditekan
            },
          ),
        ],
      ),
    );
  }
}

class SettingRedView extends GetView<SettingController> {
  const SettingRedView({super.key});

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
            title: Text(
              'Keluar',
              style: GoogleFonts.poppins(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              controller.logout();
            },
          ),

          ListTile(
            leading: const Icon(
              Symbols.delete,
              color: Colors.redAccent,
              fill: 1,
            ),
            title: Text(
              'Hapus Akun',
              style: GoogleFonts.poppins(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
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
