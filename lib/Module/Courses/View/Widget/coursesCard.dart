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
        border: Border.all(color: appColors.secondText, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OnBordingContainer(
        width: 180,
        height: 250,
        color: appColors.pageBackground,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Image.asset(
                      Images.courses,
                      width: 165,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: OnBordingContainer(
                        width: 35,
                        height: 18,
                        color: appColors.ok,
                        widget: AuthText(
                          text: 'Free',
                          size: 14,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AuthText(
                  text: 'Vue js',
                  color: appColors.mainText,
                  size: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnBordingContainer(
                    width: 40,
                    height: 20,
                    color: appColors.darkGreen,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: appColors.purple,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: AuthText(
                      text: 'Tayseer Matar baraa ', 
                      color: appColors.mainText,
                      fontWeight: FontWeight.w900,
                      size: 8,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AuthText(
                  text: 'Beginner',
                  size: 13,
                  color: appColors.darkGreen,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(Images.courses2,
                          height: 19.h,
                          width: 19.w,
                          color: appColors.seocndIconColor),
                      SizedBox(width: 5),
                      AuthText(
                        text: '30 vedio',
                        color: appColors.mainText,
                        fontWeight: FontWeight.w400,
                        size: 13,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Images.courses3,
                        width: 19.w,
                        height: 19.h,
                        color: appColors.seocndIconColor,
                      ),
                      SizedBox(width: 3),
                      AuthText(
                        text: '40 Hours',
                        color: appColors.mainText,
                        fontWeight: FontWeight.w400,
                        size: 13,
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
