import 'package:flutter/material.dart';
import 'package:snackbar_pro/snackbar_pro.dart';
 
class CustomSnackbar {
  static void show({
    required BuildContext context,
    required Color fillColor,
    required String message,
    int duration = 4,
  }) {
    // Show snackbar using SnackBarPro
    SnackBarPro.show(
      context,
      duration: Duration(seconds: duration),
      config: SnackBarProConfig(
        typingSpeed: 140,
        showPersonFigure: false,
        gradientColors: [fillColor, fillColor],
        message: message,
      ),
    );
  }
}
