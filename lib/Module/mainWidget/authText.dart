import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;

  const AuthText({
    Key? key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
    this.maxLines = 1,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size.sp,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
