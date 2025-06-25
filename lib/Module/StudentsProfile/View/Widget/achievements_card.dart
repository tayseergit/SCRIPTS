import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/Model/achievement_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class AchievementCard extends StatelessWidget {
  Achievement achievement;
  AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              border: Border.all(color: appColors.primary)),
          child: OnBoardingContainer(
            width: double.infinity,
            height: double.infinity,
            color: appColors.fieldBackground,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: AuthText(
                          text: achievement.name,
                          size: 12,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2.h,
                  ),
                  AuthText(
                      text: achievement.achieveDate,
                      size: 12,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 5.h,
                  ),
                  achievement.image != null
                      ? Image.network(
                          achievement.image!,
                          width: 170.w,
                          height: 110.h,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          Images.noImage,
                          width: 170.w,
                          height: 110.h,
                          fit: BoxFit.fill,
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
