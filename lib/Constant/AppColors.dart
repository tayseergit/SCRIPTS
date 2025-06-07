import 'package:flutter/widgets.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class AppColors {
  static const Color lihgtPrimer = Color(0xFFB797FF);
  static const Color primary = Color(0xFF6BC8FF);
  static const Color colorBackground = Color(0x0F9CEF0F);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color ok = Color(0xFF19EC67);
  static const Color blue = Color(0xFF81B9DE);
  static const Color darkBack = Color(0xFF151B22);
  static const Color darkBackground = Color(0x70686C89);
  static const Color darkGreen = Color(0xFF4DC9D1);
  static const Color lightGray = Color(0xFFDDDDDD);
  static const Color darkText = Color(0xFFCED2E6);
  static const Color lightPrimer = Color(0x1A0061FF);
  static const Color border1 = Color(0x330F9CEF);
  static const Color iconSearsh=Color(0xff8C8E98);
  static const Color gray = Color(0xFF888888);
  static const Color textField =
      Color(0xFF888888); // from "variable collection.gray"

  // Gradients
  static const LinearGradient linerContainer = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
  );

  static const LinearGradient linear = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
  );

  static const LinearGradient linerImage = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00FFFFFF), Color(0xB3248BF5)],
  );
}
