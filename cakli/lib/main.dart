import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
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
