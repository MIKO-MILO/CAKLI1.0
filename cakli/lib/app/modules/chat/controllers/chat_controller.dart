import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class ChatController extends GetxController {
  //TODO: Implement ChatController

  final count = 0.obs;
  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();

    messages.addAll([
      {
        "text":
            "Catatan Pengantaran Pelanggan:\n\nTaruh di depan pintu teras rumah dekat pot bunga raflesia warna pot warna merah.",
        "isMe": false,
        "time": "10:01 PM",
        "type": "text",
      },
      {
        "text": "Lokasi sudah sesuai ya..",
        "isMe": true,
        "time": "10:10 PM",
        "type": "text",
      },
    ]);
  }

  var messages = <Map<String, dynamic>>[].obs;
  var textController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  void sendMessage() {
    if (textController.text.trim().isEmpty) return;

    messages.add({
      "text": textController.text,
      "isMe": true,
      "time": TimeOfDay.now().format(Get.context!),
      "type": "text",
    });

    textController.clear();
  }

  void addImage(String path) {
    messages.add({
      "image": path,
      "isMe": true,
      "time": TimeOfDay.now().format(Get.context!),
      "type": "image",
    });
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      addImage(image.path);
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      addImage(image.path);
    }
  }
}
