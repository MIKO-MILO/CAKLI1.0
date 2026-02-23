import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends GetView<EditprofileController> {
  const EditprofileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        title: const Text('EditprofileView'),
        
      ),
      body: const Center(
        child: Text(
          'EditprofileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
