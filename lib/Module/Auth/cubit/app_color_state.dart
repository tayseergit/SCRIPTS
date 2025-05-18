  import 'package:flutter/material.dart';

  class ThemeState {
    final bool isDarkMode;
    final Color backgroundColor;
    final Color textColor;
    final Color textFieldColor;

    ThemeState({
      required this.isDarkMode,
      required this.backgroundColor,
      required this.textColor,
      required this.textFieldColor,
    });

    factory ThemeState.light() {
      return ThemeState(
        isDarkMode: false,
        backgroundColor: const Color(0xFFFFFFFF),
        textColor: const Color(0xFF000000),
        textFieldColor: const Color(0xFFFFFFFF),
      );
    }

    factory ThemeState.dark() {
      return ThemeState(
        isDarkMode: true,
        backgroundColor: const Color(0xFF0A0E21), // كحلي غامق
        textColor: const Color(0xFFFFFFFF), // أبيض
        textFieldColor: const Color(0xFF0D0D0D), // لون الـTextField
      );
    }
  }
