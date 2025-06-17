import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/gridViewContest.dart';
import 'package:lms/Module/Courses/View/Widget/grid_View_Courses.dart';
import 'package:lms/Module/LearnPath/View/Widget/gridViewLearnPath.dart';
 
import 'package:lms/Module/StudentsProfile/profileState.dart';
import 'package:lms/Module/TeacherProfile/TabTeacher.dart';
import 'package:lms/Module/TeacherProfile/TabTeachercubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => Tabteachercubit(),
      child: Builder(builder: (context) {
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
                      child: OnBoardingContainer(
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
                          OnBoardingContainer(
                            width: 220,
                            height: 80,
                            color: appColors.primary,
                            widget: Column(
                              children: [
                                AuthText(
                                  text: 'Tayseer Matar',
                                  size: 24,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w700,
                                ),
                                AuthText(
                                  text: 'email@gmail.com',
                                  size: 14,
                                  color: appColors.pageBackground,
                                  fontWeight: FontWeight.w700,
                                ),
                                AuthText(
                                  text: '20/5/2025 ',
                                  size: 14,
                                  color: appColors.pageBackground,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              OnBoardingContainer(
                                width: 110,
                                height: 35,
                                color: appColors.orang,
                                widget: Align(
                                  alignment: Alignment.center,
                                  child: AuthText(
                                    text: 'Intermidiate',
                                    size: 12,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              OnBoardingContainer(
                                width: 110,
                                height: 35,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Profilestate(title: 'Total Courses', value: '12'),
                    Profilestate(title: 'Total Paths', value: '5'),
                    Profilestate(title: 'Total Contests', value: '20'),
                  ],
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: Tabteacher(),
              ),
              SizedBox(
                height: 13.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                child: BlocBuilder<Tabteachercubit, int>(
                  builder: (context, state) {
                    switch (state) {
                      case 0:
                        return Gridviewcourses();
                      case 1:
                        return Gridviewlearnpath();
                      case 2:
                        return Gridviewcontest();
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

