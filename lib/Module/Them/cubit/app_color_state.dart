import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ThemeState {
  final bool isDarkMode;

  final Color lihgtPrimer;
  final Color primary;
  final Color fieldBackground;
  final Color mainText;
  final Color ok;
  final Color seocndIconColor;
  final Color mainIconColor;
  final Color pageBackground;
  final Color darkGreen;
  final Color lightGray;
  final Color secondText;
  final Color purple;
  final Color border;
  final Color iconSearsh;
  final Color darkText;
  final Color orang;

  final Color red;
  final LinearGradient linerContainer;
  final LinearGradient linear;
  final LinearGradient linerImage;

  ThemeState({
    required this.isDarkMode,
    required this.primary,
    required this.fieldBackground,
    required this.pageBackground,
    required this.ok,
    required this.red,
    required this.lihgtPrimer,
    required this.mainText,
    required this.secondText,
    required this.darkGreen,
    required this.purple,
    required this.linear,
    required this.linerContainer,
    required this.linerImage,
    required this.mainIconColor,
    required this.seocndIconColor,
    required this.border,
    required this.iconSearsh,
    required this.darkText,
    required this.orang,
    //
    required this.lightGray,
  });

  factory ThemeState.light() {
    return ThemeState(
      isDarkMode: false,
      primary: const Color(0xFF6BC8FF),
      fieldBackground: const Color(0x0F0F9CEF),
      pageBackground: const Color(0xFFFFFFFF),
      mainText: const Color.fromARGB(255, 0, 0, 0),
      secondText: const Color(0xFF888888),
      purple: const Color(0xFFB797FF),
      ok: const Color(0xFF19EC67),
      darkGreen: const Color(0xFF4DC9D1),
      red: const Color(0xFFFF3B30),
      mainIconColor: const Color(0xFF151B22),
      seocndIconColor: const Color(0xFF81B9DE),
      border: const Color(0x330F9CEF),
      iconSearsh: Color(0xff8C8E98),
      darkText: Color(0xFFCED2E6),
      orang: Color(0xffFF9500),
      //
      lightGray: const Color(0xFFDDDDDD),
      lihgtPrimer: const Color(0x1A0061FF),
      // Gradients
      linerContainer: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
      ),
      linear: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
      ),
      linerImage: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x00FFFFFF), Color(0xB3248BF5)],
      ),
    );
  }
  factory ThemeState.dark() {
    return ThemeState(
      isDarkMode: true,
      primary: const Color(0xFF3D5CFF),
      fieldBackground: const Color(0x0F9CEF0F),
      pageBackground: const Color(0xff000000),
      mainText: const Color(0xFFffffff),
      secondText: const Color(0xFF888888),
      purple: const Color(0xFFB797FF),
      ok: const Color(0xFF19EC67),
      darkGreen: const Color(0xFF4DC9D1),
      red: const Color(0xFFFF3B30),
      mainIconColor: const Color(0xFF151B22),
      seocndIconColor: const Color(0xFF81B9DE),
      border: const Color(0x330F9CEF),
      iconSearsh: Color(0xff8C8E98),
      darkText: Color(0xFFCED2E6),
      orang: Color(0xffFF9500), 

      //
      lightGray: const Color(0xFFDDDDDD),
      lihgtPrimer: const Color(0x1A0061FF),
      // Gradients
      linerContainer: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
      ),
      linear: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
      ),
      linerImage: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x00FFFFFF), Color(0xB3248BF5)],
      ),
    );
  }
}
