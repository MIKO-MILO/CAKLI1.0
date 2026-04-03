import 'package:flutter/material.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/editemail_controller.dart';

class EditemailView extends GetView<EditemailController> {
  const EditemailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'EmailView'),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  PictureProfile(),
                  const SizedBox(height: 20),
                  FormFieldEmail(),
                  const SizedBox(height: 20),
                  FormFieldEmailConfirm(),
                  const SizedBox(height: 40),
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
                style: const TextStyle(
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
    return Image.asset(
      'assets/images/editemail/icon.png',
      width: 200,
      height: 200,
    );
  }
}

class FormFieldEmail extends StatelessWidget {
  const FormFieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: "mimimimimi@gmail.com",
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: const InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Email",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(width: 4),
            Text("*", style: TextStyle(color: Colors.red)),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class FormFieldEmailConfirm extends StatelessWidget {
  const FormFieldEmailConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: "mimimimimi@gmail.com",
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: const InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Masukkan Email Kembali",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(width: 4),
            Text("*", style: TextStyle(color: Colors.red)),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
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
      width: double.infinity,
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
        child: const Text(
          'Verifikasi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
