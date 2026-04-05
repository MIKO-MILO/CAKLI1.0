import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/rating_controller.dart';

class RatingView extends GetView<RatingController> {
  const RatingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  TextTitle(),
                  SizedBox(height: 40),
                  PictureProfile(),
                  SizedBox(height: 20),
                  TextName(),
                  StarsDriver(),
                  SizedBox(height: 20),
                  StarsUser(),
                  SizedBox(height: 40),
                  TextRating(),
                  SizedBox(height: 20),
                  CustomTextField(
                    decoration: InputDecoration(
                      hintText: "Ulasan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Money(),
                  SizedBox(height: 20),
                  ButtonSubmit(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.onBackPressed, this.actions});

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
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rangkuman Transaksi",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),

                        Text(
                          "Sampai Pada",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Andai sudah Sampai",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),

                        Text(
                          "25 June 2026, 10:00 AM",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
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

class TextTitle extends StatelessWidget {
  TextTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Rating Perjalananmu Hari Ini",
      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 22.5),
    );
  }
}

class PictureProfile extends StatelessWidget {
  const PictureProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Image(image: AssetImage('assets/images/rating/profile.png')),
    );
  }
}

class TextName extends StatelessWidget {
  TextName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sucipto Putra',
      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 22),
    );
  }
}

class StarsDriver extends StatelessWidget {
  const StarsDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Symbols.kid_star, color: Color(0xFFFFC905), size: 18, fill: 1),
        Icon(Symbols.kid_star, color: Color(0xFFFFC905), size: 18, fill: 1),
        Icon(Symbols.kid_star, color: Color(0xFFFFC905), size: 18, fill: 1),
        Icon(Symbols.kid_star, color: Color(0xFFFFC905), size: 18, fill: 1),
        Icon(Symbols.kid_star, color: Color(0xFFFFC905), size: 18, fill: 1),
      ],
    );
  }
}

class StarsUser extends StatelessWidget {
  const StarsUser({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true, // bisa setengah bintang
      itemCount: 5,
      itemSize: 55,
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

class TextRating extends StatelessWidget {
  TextRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Apa Yang Buat Kamu Terkesan?',
      textAlign: TextAlign.center,
      maxLines: 2,
      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required InputDecoration decoration});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        hintText: "Ketik Disini",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
      ),
    );
  }
}

class Money extends StatelessWidget {
  const Money({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Icon(Symbols.money, size: 24, fill: 1),
              const SizedBox(width: 5),
              Text(
                '2000',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.HOME);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFE04D04),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        child: Text(
          'Kirim',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 22),
        ),
      ),
    );
  }
}
