import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cakli/app/routes/app_pages.dart';

import '../controllers/rating_controller.dart';

class RatingView extends GetView<RatingController> {
  const RatingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// KIRI
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rangkuman Transaksi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text("Anda sudah sampai!", style: TextStyle(fontSize: 14)),
              ],
            ),

            /// KANAN
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Sampai Pada", style: TextStyle(fontSize: 14)),
                Text(
                  "25 June 2026, 06:07 AM",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Rating Perjalananmu Hari Ini",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image(
                  image: AssetImage('assets/images/rating/profile.png'),
                ),
              ),

              const Text(
                'Sucipto Putra',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.kid_star,
                    color: Color(0xFFFFC905),
                    size: 28,
                    fill: 1,
                  ),
                  Icon(
                    Symbols.kid_star,
                    color: Color(0xFFFFC905),
                    size: 28,
                    fill: 1,
                  ),
                  Icon(
                    Symbols.kid_star,
                    color: Color(0xFFFFC905),
                    size: 28,
                    fill: 1,
                  ),
                  Icon(
                    Symbols.kid_star,
                    color: Color(0xFFFFC905),
                    size: 28,
                    fill: 1,
                  ),
                  Icon(
                    Symbols.kid_star,
                    color: Color(0xFFFFC905),
                    size: 28,
                    fill: 1,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true, // bisa setengah bintang
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),

              const SizedBox(height: 30),

              Text(
                'Apa Yang Buat Kamu Terkesan?',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 16,
                          ),
                          hintText: "Ketik Disini",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/rating');
                  },

                  child: Container(
                    height: 75,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Colors.black54, width: 1),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Symbols.money, size: 24, fill: 1),
                            const SizedBox(width: 5),
                            Text(
                              '2000',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.HOME);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFE04D04),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Kirim',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
