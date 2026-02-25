import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setlokasi_controller.dart';

class SetlokasiView extends GetView<SetlokasiController> {
  const SetlokasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetlokasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SetlokasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
