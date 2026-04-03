import 'package:flutter/material.dart';
import 'package:cakli/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/editalamat_controller.dart';

class EditalamatView extends GetView<EditalamatController> {
  const EditalamatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Edit Alamat'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    ContainerAdrres(),
                    ContainerAdrres(),
                    ContainerAdrres(),
                    ContainerAdrres(),
                    ContainerAdrres(),
                    ContainerAdrres(),
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(20), child: ButtonAddAdress()),
        ],
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

class ContainerAdrres extends StatelessWidget {
  const ContainerAdrres({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(children: [HeaderContainerAdrres(), FillContainerAdrres()]),
    );
  }
}

class HeaderContainerAdrres extends StatelessWidget {
  const HeaderContainerAdrres({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        color: Color(0xFFE04D04), // orange
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
    );
  }
}

class FillContainerAdrres extends StatelessWidget {
  const FillContainerAdrres({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        "Jl. Tanimbar No. 22 Lorem Ipsum dolor sit Amet blablaskdkjieygdyt",
        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
      ),
    );
  }
}

class ButtonAddAdress extends StatelessWidget {
  const ButtonAddAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TAMBAHALAMAT);
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
          'Tambah Alamat',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
