import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:cakli_driver/services/token_service.dart';

String _getInitialRoute() {
  if (TokenService.isLoggedIn) {
    return Routes.HOME; // atau halaman utama kamu
  } else {
    return Routes.LOGIN;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 INIT TOKEN DULU
  await TokenService.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: _getInitialRoute(), // 🔥 pakai function
      getPages: AppPages.routes,
      theme: ThemeData(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
          child: child!,
        );
      },
    ),
  );
}
