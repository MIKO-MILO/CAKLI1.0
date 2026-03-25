import 'package:get/get.dart';

class ListchatController extends GetxController {
  //TODO: Implement ListchatController

  final count = 0.obs;



  void increment() => count.value++;

  var chats = [
    {
      "name": "FK-389835353",
      "message": "Anda : Sama-sama......",
      "time": "10:45 AM",
    },
    {
      "name": "FK-389835353",
      "message": "Anda : Sama-sama...",
      "time": "10:45 AM",
    },
  ].obs;
}
