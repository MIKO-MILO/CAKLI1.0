import 'package:cakli/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:get/get.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    const double overlapOffset = 650;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/setting/ilustrasi.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: overlapOffset,
                  left: 30,
                  right: 30,
                  child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/setting/profile.png'),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aulia Sukma',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('auliasr.edu@gmail.com'),
                            Text('0821345678'),
                          ],
                        ),
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.EDITPROFILE);
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: 30,
                  child: Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  left: 30,
                  right: 30,
                  child: Container(
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
                          title: const Text('Ganti Email'),
                          onTap: () {
                            Get.toNamed(Routes.EDITEMAIL);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Symbols.credit_card, fill: 1),
                          title: const Text('Ganti PIN E-Wallet'),
                          onTap: () {
                            // Aksi saat menu Notifikasi ditekan
                            Get.toNamed(Routes.EDITPIN);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.bookmark),
                          title: const Text('Alamat Tersimpan'),
                          onTap: () {
                            Get.toNamed(Routes.EDITALAMAT);
                          },
                        ),

                        ListTile(
                          leading: const Icon(Symbols.history, fill: 1, weight: 900),
                          title: const Text('Riwayat'),
                          onTap: () {
                            Get.toNamed(Routes.AKTIVITAS);
                          },
                        ),

                        ListTile(
                          leading: const Icon(Symbols.star, fill: 1),
                          title: const Text('Beri Rating'),
                          onTap: () {
                            // Aksi saat menu Privasi ditekan
                          },
                        ),

                        ListTile(
                          leading: const Icon(Symbols.settings, fill: 1),
                          title: const Text('MAPTEST'),
                          onTap: () {
                            Get.toNamed(Routes.MAPTEST);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  // top: MediaQuery.of(context).size.height * 0.69,
                  top: MediaQuery.of(context).size.height * 0.73,
                  left: 30,
                  right: 30,
                  child: Container(
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

                        ListTile(
                          leading: const Icon(
                            Symbols.delete,
                            color: Colors.redAccent, 
                            fill: 1,
                          ),
                          title: const Text(
                            'Hapus Akun',
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
