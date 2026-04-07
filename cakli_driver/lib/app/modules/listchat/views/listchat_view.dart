import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cakli_driver/app/modules/chat/views/chat_view.dart';

import '../controllers/listchat_controller.dart';

class ListchatView extends GetView<ListchatController> {
  const ListchatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Kembali'),
      body: ChatPage(),
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
                  fontWeight: FontWeight.w600,
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

class ChatPage extends StatelessWidget {
  final ListchatController controller = Get.put(ListchatController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatView());
      },
      child: Obx(
        () => ListView.separated(
          itemCount: controller.chats.length,
          separatorBuilder: (_, _) => Divider(
            color: Color(0xFFE04D04),
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, index) {
            var chat = controller.chats[index];

            return ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person, color: Colors.grey.shade700),
              ),
              title: Text(
                chat["name"]!,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                chat["message"]!,
                style: GoogleFonts.poppins(color: Colors.black54),
              ),
              trailing: Text(
                chat["time"]!,
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
