import 'package:cakli/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/editprofile_controller.dart';

class EditprofileView extends GetView<EditprofileController> {
  const EditprofileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Edit Profile'),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  PictureProfile(),
                  TextEditButton(),
                  SizedBox(height: 50),
                  FormFieldName(),
                  SizedBox(height: 20),
                  FormFieldEmail(),
                  SizedBox(height: 20),
                  FormFieldPhone(),
                  SizedBox(height: 40),
                  ButtonSubmit(),
                ],
              ),
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

class PictureProfile extends StatelessWidget {
  const PictureProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // klik tutup
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/editprofile/profile.png', // ganti sesuai gambar kamu
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        radius: 45,
        backgroundImage: AssetImage('assets/images/editprofile/profile.png'),
      ),
    );
  }
}

class TextEditButton extends StatelessWidget {
  TextEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('Klik Edit Foto');
      },
      child: Text(
        'Edit Foto',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

class FormFieldName extends StatelessWidget {
  const FormFieldName({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: "Ustadzah",
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nama",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(width: 4),
            Text("*", style: GoogleFonts.poppins(color: Colors.red)),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class FormFieldPhone extends StatelessWidget {
  const FormFieldPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: "08123456567",
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nomor Telepon",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(width: 4),
            Text("*", style: GoogleFonts.poppins(color: Colors.red)),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class FormFieldEmail extends StatelessWidget {
  const FormFieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: "mimimimimi@gmail.com",
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Email",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(width: 4),
            Text("*", style: GoogleFonts.poppins(color: Colors.red)),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.SETTING);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFE04D04),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Simpan',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
