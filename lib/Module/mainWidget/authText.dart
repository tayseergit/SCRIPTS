import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
 
class AuthText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  const AuthText({
    super.key,
    required this.text,
    this.size = 10,
    this.color, // نخليه اختياري، وإذا ما انبعت ناخد من الثيم
    this.fontWeight = FontWeight.w600, // default fontWeight
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: overflow,
      style: TextStyle(
        fontSize: size?.sp,
        color: color ?? appColors.mainText, // إذا ما مررت لون، ناخد من الثيم
        fontWeight: fontWeight,
      ),
    );
  }
}
