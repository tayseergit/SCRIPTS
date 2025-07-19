import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Customtextfieldsearsh extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final VoidCallback? onSubmit;

  final String? errorText;
  final String? hintText;
  final double borderRadius;
  final double hintFontSize;
  final FontWeight hintFontWeight;
  final Color? fillColor;
  final Color? hintColor;
  final Color? borderColor;

  Customtextfieldsearsh(
      {super.key,
      required this.controller,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.errorText,
      this.hintText,
      this.borderRadius = 30.0,
      this.hintFontSize = 16.0,
      this.hintFontWeight = FontWeight.normal,
      this.borderColor,
      this.fillColor,
      this.hintColor,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      decoration: BoxDecoration(
        color: appColors.pageBackground,
        border: Border(
          top: BorderSide(color: appColors.border, width: 1),
          right: BorderSide(color: appColors.border, width: 1),
          bottom: BorderSide(color: appColors.border, width: 4),
          left: BorderSide(color: appColors.border, width: 4),
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: TextStyle(color: appColors.mainText),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: hintFontSize.sp,
            fontWeight: hintFontWeight,
            color: appColors.secondText,
          ),
          border: InputBorder.none,
          prefixIcon: prefixIcon ??
              IconButton(
                onPressed: onSubmit,
                icon: Icon(Icons.search, color: appColors.mainIconColor),
                color: appColors.mainIconColor,
              ),
          suffixIcon: suffixIcon ??
              Image.asset(
                Images.filter,
                width: 10.w,
                height: 10.h,
                color: appColors.mainIconColor,
              ),
          errorText: errorText,
        ),
      ),
    );
  }
}
