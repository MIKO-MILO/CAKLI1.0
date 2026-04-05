import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Pengaturan"),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SettingView(
              Ikon: Icons.settings,
              Judul: 'Ganti Nomor',
              Subjudul: '+621234567899',
            ),

            SettingView(
              Ikon: Icons.email,
              Judul: 'Email',
              Subjudul: '@sabrina1@gmail.com',
            ),

            SettingView(
              Ikon: Icons.car_rental,
              Judul: 'Nomor Kendaraan ',
              Subjudul: 'B 1234 AB',
            ),

            SettingView(
              Ikon: Icons.credit_card,
              Judul: 'Rekening bank',
              Subjudul: 'PT. BANK RAKYAT INDONESIA (PERSERO) H*** T** 7655',
            ),

            SettingView(
              Ikon: Icons.work,
              Judul: 'Pemilihan Layanan',
              Subjudul: 'Daftar pilihan layanan',
            ),

            SettingView(
              Ikon: Icons.delete,
              Judul: 'Rekening bank',
              Subjudul: 'Hapus akun anda selamanya.',
            ),
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

class SettingView extends StatelessWidget {
  final IconData Ikon;
  final String Judul;
  final String Subjudul;

  const SettingView({
    super.key,
    required this.Ikon,
    required this.Judul,
    required this.Subjudul,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Ikon, color: Colors.black, size: 30),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Judul,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      Subjudul,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),

          SizedBox(height: 12),

          Divider(thickness: 1, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
