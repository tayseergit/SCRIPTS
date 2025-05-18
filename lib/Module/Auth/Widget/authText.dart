import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthText extends StatelessWidget {
  final String text;
  final double size;
  final Color coloer;
  final FontWeight fontWeight;
  const AuthText({
    super.key,
    required this.text,
    required this.size,
    required this.coloer,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      color: coloer,
      fontSize: size.sp,
      fontWeight: fontWeight,
    ));
  }
}
