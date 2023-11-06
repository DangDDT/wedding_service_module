import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType { success, error, warning, info }

class SnackBarHelper {
  static void show({
    required String message,
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = GetSnackBar(
      message: message,
      duration: duration,
      backgroundColor: _getBackgroundColor(type),
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.showSnackbar(snackBar);
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }
}
