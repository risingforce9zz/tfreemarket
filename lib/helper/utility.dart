import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Utility {
  static customSnackBar(String title,
      String message, [
        String? status,
      ]) {
    if (status != null) {
      late Icon icon;
      Color backgroundColor = HexColor('#FEEBFC');
      Color textColor = HexColor('#86468B');
      Color iconColor = HexColor('#FBC425');
      switch (status) {
        case 'success':
          backgroundColor = HexColor('#28a745');
          icon = Icon(Icons.task_alt, size: 24.0, color: textColor);
          break;
        case 'info':
          backgroundColor = HexColor('#007bff');
          icon = Icon(Icons.info_outline_rounded,
              size: 24.0, color: textColor);
          break;
        case 'warn':
          icon = Icon(Icons.warning_amber, size: 24.0, color: iconColor);
          break;
        case 'error':
          backgroundColor = HexColor('#dc3545');
          icon = Icon(Icons.error_outline, size: 24.0, color: textColor);
          break;
        default:
          break;
      }
      Get.snackbar(title, message,
          backgroundColor: backgroundColor,
          colorText: textColor,
          snackPosition: SnackPosition.BOTTOM,
          icon: icon,
          borderRadius: 5.0,
          borderColor: HexColor('#6c757d'),
          borderWidth: 2
      );
    } else {
      Get.snackbar(title, message,
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
