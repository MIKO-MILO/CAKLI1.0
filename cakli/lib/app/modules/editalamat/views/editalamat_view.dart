import 'package:flutter/material.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/editalamat_controller.dart';

class EditalamatView extends GetView<EditalamatController> {
  const EditalamatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        title: const Text('EditalamatView'),
        backgroundColor: const Color(0xFFEBE8E8),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ================= HEADER =================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD46A2E), // orange
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.bookmark, color: Colors.white),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "SMKN 4 MALANG",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.more_horiz, color: Colors.white),
                      ],
                    ),
                  ),

                  /// ================= BODY =================
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Jl. Tanimbar No. 22 Lorem Ipsum dolor sit Amet blablaskdkjieygdyt",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ================= HEADER =================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD46A2E), // orange
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.bookmark, color: Colors.white),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "SMKN 4 MALANG",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.more_horiz, color: Colors.white),
                      ],
                    ),
                  ),

                  /// ================= BODY =================
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Jl. Tanimbar No. 22 Lorem Ipsum dolor sit Amet blablaskdkjieygdyt",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD46A2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Get.toNamed(Routes.TAMBAHALAMAT);
            },
            child: const Text(
              "Tambah Alamat Baru",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
