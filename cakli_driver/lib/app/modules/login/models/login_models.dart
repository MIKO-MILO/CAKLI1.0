import 'package:flutter/material.dart';

enum AlertType { error, warning, success, info }

class AlertData {
  final String title;
  final String message;
  final AlertType type;

  const AlertData({
    required this.title,
    required this.message,
    required this.type,
  });

  factory AlertData.error({required String title, required String message}) =>
      AlertData(title: title, message: message, type: AlertType.error);

  factory AlertData.warning({required String title, required String message}) =>
      AlertData(title: title, message: message, type: AlertType.warning);

  factory AlertData.success({required String title, required String message}) =>
      AlertData(title: title, message: message, type: AlertType.success);

  factory AlertData.info({required String title, required String message}) =>
      AlertData(title: title, message: message, type: AlertType.info);

  Color get backgroundColor {
    switch (type) {
      case AlertType.error:
        return const Color(0xFFFDEDED);
      case AlertType.warning:
        return const Color(0xFFFFF8E1);
      case AlertType.success:
        return const Color(0xFFE8F5E9);
      case AlertType.info:
        return const Color(0xFFE3F2FD);
    }
  }

  Color get borderColor {
    switch (type) {
      case AlertType.error:
        return const Color(0xFFEF9A9A);
      case AlertType.warning:
        return const Color(0xFFFFCC80);
      case AlertType.success:
        return const Color(0xFFA5D6A7);
      case AlertType.info:
        return const Color(0xFF90CAF9);
    }
  }

  Color get textColor {
    switch (type) {
      case AlertType.error:
        return const Color(0xFFB71C1C);
      case AlertType.warning:
        return const Color(0xFFE65100);
      case AlertType.success:
        return const Color(0xFF1B5E20);
      case AlertType.info:
        return const Color(0xFF0D47A1);
    }
  }

  IconData get icon {
    switch (type) {
      case AlertType.error:
        return Icons.error_outline_rounded;
      case AlertType.warning:
        return Icons.warning_amber_rounded;
      case AlertType.success:
        return Icons.check_circle_outline_rounded;
      case AlertType.info:
        return Icons.info_outline_rounded;
    }
  }
}
