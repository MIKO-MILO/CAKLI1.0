import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBE8E8),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/pesandriver/profile.png",
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Febrian",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "N 1234 SYBAU",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(width: 45),

                    Row(
                      children: [
                        Icon(
                          Symbols.circle,
                          size: 12,
                          color: Colors.green,
                          fill: 1,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Becak Honda A70s",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(height: 3, thickness: 1, color: Colors.black54),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  ChatBubble(text: "Baik kak, ditunggu ya", isMe: false),
                  ChatBubble(text: "Iyaa", isMe: true),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Ketik Disini",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.send, color: Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text),
            SizedBox(height: 4),
            Text("13.00", style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
