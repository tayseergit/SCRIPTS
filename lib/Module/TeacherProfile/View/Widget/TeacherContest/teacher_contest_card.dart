import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_contest_model.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/ReadMoreInlineText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class TeacherContestCard extends StatelessWidget {
  final TeacherContestData teacherContestData;
  TeacherContestCard({super.key, required this.teacherContestData,});
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: appColors.secondText, width: 1),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: OnBoardingContainer(
          color: appColors.pageBackground,
          widget: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.h, top: 10.h),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250.w,
                            child: AuthText(
                              text: teacherContestData.name,
                              size: 20,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AuthText(
                            text: 'Description:',
                            size: 15,
                            color: appColors.secondText,
                            fontWeight: FontWeight.w700,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ReadMoreInlineText(
                              text: teacherContestData.description,
                              trimLength: 19,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          AuthText(
                            text: teacherContestData.type,
                            size: 15,
                            color: appColors.purple,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Images.contest4,
                                    height: 15.h,
                                    width: 15.w,
                                    color: appColors.primary,
                                  ),
                                  SizedBox(width: 3.w),
                                  AuthText(
                                    text: teacherContestData.startAt,
                                    size: 14,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              SizedBox(width: 15.w),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Image.asset(
                                Images.contest5,
                                height: 15.h,
                                width: 15.w,
                                color: appColors.primary,
                              ),
                              SizedBox(width: 3.w),
                              AuthText(
                                text: "${teacherContestData.time} min",
                                size: 14,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          teacherContestData.status == "ended"
                              ? OnBoardingContainer(
                                  radius: 20,
                                  width: 130,
                                  height: 40,
                                  color: appColors.blackGreen,
                                  widget: AuthText(
                                    text: 'Leader Board',
                                    size: 16,
                                    color: appColors.whiteText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 10.h),
                        ]),
                    Column(
                      children: [
                        OnBoardingContainer(
                          width: 70.w,
                          height: 20.h,
                          color: appColors.ok,
                          widget: AuthText(
                            text: teacherContestData.status,
                            size: 10,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              Images.cup,
                              width: 75.w,
                              height: 100.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: AuthText(
                                text: teacherContestData.status == "active"
                                    ? 'Join'
                                    : teacherContestData.status == "coming"
                                        ? "Register"
                                        : "",
                                size: 10,
                                color: appColors.mainText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
