import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pendapatan_controller.dart';

class PendapatanView extends GetView<PendapatanController> {
  const PendapatanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PendapatanView'),
      ),
      body: const Center(
        child: Text(
          'PendapatanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
