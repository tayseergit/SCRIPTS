import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Rowmore extends StatelessWidget {
  final String text;
  final String image;
  final double height;
  final double width;

  final void Function() onTapp;
  const Rowmore({
    super.key,
    required this.text,
    required this.image,
    required this.onTapp,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: onTapp,
        child: Row(
          
          children: [
            Image.asset(image, height: height.h, width: width.w),
            SizedBox(width: 15.w,),
            AuthText(
              text: text,
              size: 19,
              color: appColors.mainText,
              fontWeight: FontWeight.w400,
            ),
            
          ],
        ),
      ),
    );
  }
}
