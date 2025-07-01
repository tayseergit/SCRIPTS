import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Coursesvediocard extends StatelessWidget {
  const Coursesvediocard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.border,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 6.h),
        child: Row(
          children: [
            Image.asset(
              Images.courses,
              height: 60.h,
              width: 60.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AuthText(
                      text: '01',
                      size: 24,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AuthText(
                      text: 'Welcome to the Course',
                      size: 16,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                Row(
                  children: [
                    AuthText(
                      text: '6.18',
                      size: 14,
                      color: appColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AuthText(
                      text: 'mins',
                      size: 14,
                      color: appColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: appColors.ok,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(width: 17.w,),
            IconButton(onPressed: (){}, icon: Icon(Icons.play_circle_fill_outlined,color: appColors.primary,size: 50,))
          ],
        ),
      ),
    );
  }
}
