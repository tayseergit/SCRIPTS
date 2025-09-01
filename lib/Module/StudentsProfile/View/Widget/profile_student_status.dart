import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart' show ThemeState;
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Profilestate extends StatelessWidget {
  final String title;
  final String value;

  const Profilestate({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: appColors.blackGreen.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            child: OnBoardingContainer(
              height: 55,
              color: appColors.blackGreen
                  .withOpacity(0.05), 
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthText(
                    text: title,
                    size: 8.sp,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4.h),
                  AuthText(
                    text: value,
                    size: 12.sp,
                    color: appColors.mainText,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
