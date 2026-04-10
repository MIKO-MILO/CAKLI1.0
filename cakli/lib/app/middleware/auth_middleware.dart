import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../../services/token_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!TokenService.isLoggedIn) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}
