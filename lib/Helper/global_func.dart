import 'package:flutter/material.dart';

class GlobalFunc {
  static bool passwordValid({required String password}) {
    // Check length (>= 8)
    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    } else {
      return true;
    }
  }

  static bool validEmail(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (email.isNotEmpty) {
      if (emailRegex.hasMatch(email)) {
        return true;
      } else {
        return false;
      }
    } else {
     return false;

    }
  }
}
