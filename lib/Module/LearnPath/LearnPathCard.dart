import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Module/LearnPath/TopWaveClipper.dart' show TopWaveClipper;
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Learnpathcard extends StatelessWidget {
  const Learnpathcard({super.key});

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
        widget: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: TopWaveClipper(),
                    child: Container(
                      height: 100.h,
                      width: double.infinity.w,
                      color: Colors.blue.shade100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Front end development',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: OnBordingContainer(
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
            Image.asset(
              Images.learnPath1,
              width: 230.w,
              height: 200.h,
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnBordingContainer(
                    width: 130,
                    height: 40,
                    color: appColors.primary,
                    widget: AuthText(
                      text: 'View Path',
                      size: 20,
                      color: appColors.fieldBackground,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  OnBordingContainer(
                    width: 90,
                    height: 30,
                    color: appColors.lihgtPrimer,
                    widget: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.courses3,
                            width: 19.w,
                            height: 19.h,
                            color: appColors.mainIconColor,
                          ),
                          SizedBox(width: 2),
                          AuthText(
                            text: '40 Hours',
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
                  OnBordingContainer(
                    width: 90,
                    height: 30,
                    color: appColors.lihgtPrimer,
                    widget: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                          children: [
                            Image.asset(
                              Images.courses2,
                              height: 19.h,
                              width: 19.w,
                              color: appColors.mainText,
                            ),
                            SizedBox(width: 2),
                            AuthText(
                              text: '30 vedio',
                              color: appColors.mainText,
                              fontWeight: FontWeight.w400,
                              size: 13,
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
