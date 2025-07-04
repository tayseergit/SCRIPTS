import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/LearnPath/Model/learn_path_reaponse.dart';
 import 'package:lms/Module/LearnPath/View/Widget/TopWaveClipper.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Learnpathcard extends StatelessWidget {
    Learnpathcard({super.key,required this.learnPath});
  LearningPath learnPath;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColors.border, width: 3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OnBoardingContainer(
        width: 180,
        height: 10,
        color: appColors.pageBackground,
        widget: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: 70,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: TopWaveClipper(),
                    child: Container(
                      height: 100.h,
                      width: double.infinity.w,
                      color: appColors.lihgtPrimer,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AuthText(text: learnPath.title, size: 16, color: appColors.mainText, fontWeight: FontWeight.w600)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: OnBoardingContainer(
                        width: 60,
                        height: 40,
                        color: appColors.ok,
                        widget: AuthText(
                          text: 'Free',
                          size: 12,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: SizedBox(
                width: double
                    .infinity, // take all available width of the parent container
                height: 200.h, // keep the height you want
                child: Image.asset(
                  Images.learnPath1,
                  fit: BoxFit
                      .cover, // or BoxFit.fill, BoxFit.contain, depending on your need
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnBoardingContainer(
                    width: 130,
                    height: 40,
                    color: appColors.primary,
                    widget: AuthText(
                      text: 'View Path',
                      size: 20,
                      color: appColors.pageBackground,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  OnBoardingContainer(
                    width: 90,
                    height: 30,
                    color: appColors.purple,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.courses3,
                            width: 18.w,
                            height: 18.h,
                            color: appColors.mainText,
                          ),
                          AuthText(
                            text: '40 Hours',
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  OnBoardingContainer(
                    width: 90,
                    height: 30,
                    color: appColors.purple,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.courses2,
                            height: 18.h,
                            width: 18.w,
                            color: appColors.mainText,
                          ),
                          SizedBox(width: 2),
                          AuthText(
                            text: '30 vedio',
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
