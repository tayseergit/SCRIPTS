import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                Images.courses,
                width: double.infinity,
                height: 380,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 15.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: OnBordingContainer(
                    width: 90,
                    height: 25,
                    color: appColors.darkText,
                    widget: AuthText(
                      text: 'Edit Profile',
                      size: 14,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OnBordingContainer(
                        width: 220,
                        height: 68,
                        color: appColors.primary,
                        widget: Column(
                          children: [
                            AuthText(
                              text: 'Tayseer Matar',
                              size: 24,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            AuthText(
                              text: 'email@gmail.com20/5/2025',
                              size: 14,
                              color: appColors.pageBackground,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        children: [
                          OnBordingContainer(
                            width: 110,
                            height: 35,
                            color: appColors.orang,
                            widget: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AuthText(
                                    text: 'Intermidiate',
                                    size: 12,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OnBordingContainer(
                            width: 110,
                            height: 30,
                            color: appColors.darkText,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.github,
                                  height: 20.h,
                                  width: 20.w,
                                  color: appColors.mainText,
                                ),
                                SizedBox(width: 15.w),
                                AuthText(
                                  text: 'GitHub',
                                  color: appColors.mainText,
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: OnBordingContainer(
                    width: 80,
                    height: 40,
                    color: appColors.pageBackground,
                    widget: Column(
                      children: [
                        AuthText(
                            text: 'Current Streak',
                            size: 8,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                        SizedBox(
                          height: 2.h,
                        ),
                        AuthText(
                            text: '12 Days',
                            size: 15,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: OnBordingContainer(
                    width: 80,
                    height: 40,
                    color: appColors.pageBackground,
                    widget: Column(
                      children: [
                        AuthText(
                            text: 'Course Completed',
                            size: 8,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                        SizedBox(
                          height: 2.h,
                        ),
                        AuthText(
                            text: '5',
                            size: 15,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: OnBordingContainer(
                    width: 80,
                    height: 40,
                    color: appColors.pageBackground,
                    widget: Column(
                      children: [
                        AuthText(
                            text: 'Path Completed',
                            size: 8,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                        SizedBox(
                          height: 2.h,
                        ),
                        AuthText(
                            text: '20',
                            size: 15,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: OnBordingContainer(
                    width: 80,
                    height: 40,
                    color: appColors.pageBackground,
                    widget: Column(
                      children: [
                        AuthText(
                            text: 'Total Points',
                            size: 8,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                        SizedBox(
                          height: 2.h,
                        ),
                        AuthText(
                            text: '2578',
                            size: 15,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
