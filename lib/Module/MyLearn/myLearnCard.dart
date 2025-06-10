import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Mylearncard extends StatelessWidget {
  const Mylearncard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    double progressValue = 0.4;
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
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Image.asset(
                Images.courses,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.h),
                  AuthText(
                    text: 'React js',
                    size: 18,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(Images.courses2,
                              height: 19.h, width: 19.w, color: appColors.seocndIconColor),
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
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OnBordingContainer(
                        width: 40,
                        height: 15,
                        color: appColors.darkGreen,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(Images.courses1),
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
                      SizedBox(width: 10.w),
                      OnBordingContainer(
                        width: 70,
                        height: 15,
                        color: appColors.purple,
                        widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: AuthText(
                            text: 'Tayseer Matar',
                            color: appColors.mainText,
                            fontWeight: FontWeight.w900,
                            size: 8,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      AuthText(
                        text: 'Beginner',
                        size: 10,
                        color: appColors.ok,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                 
                     LinearPercentIndicator(
                      width: 210,
                      lineHeight: 13.0,
                      percent: progressValue,
                      backgroundColor: appColors.fieldBackground,
                      progressColor: appColors.ok,
                      animation: true,
                      animationDuration: 800,
                      barRadius: Radius.circular(10),
                    ),
                  // ),
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
