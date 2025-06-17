import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Cursescard extends StatelessWidget {
  const Cursescard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColors.lihgtPrimer, width: 2.w),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: OnBoardingContainer(
        width: 180.w,
        height: 250.h,
        color: appColors.pageBackground,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Image.asset(
                      Images.courses,
                      width: double.infinity,
                      height: 100.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    child: OnBoardingContainer(
                      width: 40.w,
                      height: 20.h,
                      color: appColors.ok,
                      widget: Center(
                        child: AuthText(
                          text: 'Free',
                          size: 12.sp,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              AuthText(
                text: 'Vue js',
                color: appColors.mainText,
                size: 20.sp,
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              // SizedBox(height: 10.h),
              Row(
                children: [
                  OnBoardingContainer(
                    width: 50.w,
                    height: 25.h,
                    color: appColors.darkGreen,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            Images.courses1,
                            width: 15.w,
                            height: 15.h,
                          ),
                          AuthText(
                            text: '5.0',
                            color: appColors.mainText,
                            fontWeight: FontWeight.w900,
                            size: 12.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: appColors.purple,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: AuthText(
                        text: 'Tayseer Matar baraa',
                        color: appColors.mainText,
                        fontWeight: FontWeight.w900,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              AuthText(
                text: 'Beginner',
                size: 14.sp,
                color: appColors.darkGreen,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.courses2,
                        height: 18.h,
                        width: 18.w,
                        color: appColors.seocndIconColor,
                      ),
                      SizedBox(width: 5.w),
                      AuthText(
                        text: '30 videos',
                        color: appColors.mainText,
                        fontWeight: FontWeight.w400,
                        size: 10.sp,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Images.courses3,
                        width: 18.w,
                        height: 18.h,
                        color: appColors.seocndIconColor,
                      ),
                      SizedBox(width: 5.w),
                      AuthText(
                        text: '40 Hours',
                        color: appColors.mainText,
                        fontWeight: FontWeight.w400,
                        size: 10.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
