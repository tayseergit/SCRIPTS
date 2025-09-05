import 'package:flutter/material.dart';

class ThemeState {
  bool isDarkMode;

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
  final Color whiteText;
  final Color strongPrimer;
  final Color blackGreen;
  final Color blackGreenDisable;
  final Color cyanAccent;
  final Color shadow;
  final Color lightfieldBackground;

  final Color red;
  final LinearGradient linerContainer;
  final LinearGradient linear;

  final LinearGradient linerImage;
  ThemeState({
    required this.strongPrimer,
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
    required this.whiteText,
    required this.orang,
    required this.blackGreen,
    required this.blackGreenDisable,
    required this.lightfieldBackground,
    required this.cyanAccent,
    required this.shadow,
    //
    required this.lightGray,
  });

  factory ThemeState.light() {
    return ThemeState(
      isDarkMode: false,
      primary: const Color.from(alpha: 1, red: 0.729, green: 0.729, blue: 0.729),
      fieldBackground: const Color(0x0F0F9CEF),
      pageBackground: const Color(0xFFFFFFFF),
      whiteText: const Color(0xFFFFFFFF),
      mainText: const Color.fromARGB(255, 0, 0, 0),
      secondText: const Color.fromARGB(255, 119, 119, 119),
      purple: const Color(0xFFB797FF),
      ok: const Color.fromARGB(255, 21, 197, 86),
      darkGreen: const Color(0xFF4DC9D1),
      red: const Color(0xFFFF3B30),
      mainIconColor: const Color(0xFF151B22),
      seocndIconColor: const Color(0xFF81B9DE),
      border: const Color.fromARGB(138, 58, 143, 255),
      iconSearsh: Color(0xff8C8E98),
      darkText: Color.fromARGB(255, 35, 35, 35),
      orang: Color(0xFFFF6E40),
      strongPrimer: const Color.fromARGB(255, 24, 112, 163),
      blackGreen: const Color(0xFF1B4965),
      blackGreenDisable: Color(0xFF1B4965).withOpacity(0.38),
      cyanAccent: Color(0xFF18FFFF),
      shadow: Color.fromARGB(255, 91, 168, 168),
      lightfieldBackground: Color.fromARGB(255, 255, 255, 255),

      //
      lightGray: const Color(0xFFDDDDDD),
      lihgtPrimer: const Color.fromARGB(127, 107, 201, 255),
      // Gradients
      linerContainer: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
      ),
      linear: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0xFFFFFFFF), Color(0xA06BC8FF)],
      ),
      linerImage: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x00FFFFFF), Color.fromARGB(179, 70, 162, 253)],
      ),
    );
  }
  factory ThemeState.dark() {
    return ThemeState(
      isDarkMode: true,
      primary: const Color(0xFF6BC8FF),
      fieldBackground: const Color(0x0F9CEF0F),
      pageBackground: const Color(0xFF1C1B1B),
      whiteText: const Color(0xFFffffff),
      mainText: const Color(0xFFffffff),
      secondText: const Color.fromARGB(255, 197, 197, 197),
      purple: const Color(0xFFB797FF),
      ok: const Color(0xFF19EC67),
      darkGreen: const Color(0xFF4DC9D1),
      red: const Color(0xFFFF3B30),
      mainIconColor: const Color.fromARGB(255, 244, 244, 245),
      seocndIconColor: const Color(0xFF81B9DE),
      border: const Color.fromARGB(171, 123, 202, 255),
      iconSearsh: Color(0xff8C8E98),
      darkText: Color(0xFFCED2E6),
      orang: Color(0xFFFF6E40),
      strongPrimer: const Color.fromARGB(255, 24, 112, 163),
      blackGreen: const Color(0xFF1B4965),
      blackGreenDisable: const Color(0xFF1B4965),
      cyanAccent: Color(0xFF18FFFF),
      shadow: Color.fromARGB(255, 63, 105, 105),
      lightfieldBackground: Color.fromARGB(255, 68, 72, 72),

      //
      lightGray: const Color.fromARGB(134, 189, 189, 189),
      lihgtPrimer: const Color(0x803D5DFF),

      // Gradients
      linerContainer: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFFFFF), Color(0xFF248BF5)],
      ),
      linear: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0xFFFFFFFF), Color.fromARGB(255, 107, 201, 255)],
      ),
      linerImage: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x00FFFFFF), Color.fromARGB(179, 70, 162, 253)],
      ),
    );
  }
}
