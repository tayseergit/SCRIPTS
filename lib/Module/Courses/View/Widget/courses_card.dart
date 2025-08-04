import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseInfo/View/Pages/course_info_page.dart';
import 'package:lms/Module/Courses/Model/course_response.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Cursescard extends StatelessWidget {
  Cursescard({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return GestureDetector(
      onTap: () {
        pushTo(context: context, toPage: CourseInfoPage(courseId: course.id));
      },
      child: Container(
        width: 180.w,
        decoration: BoxDecoration(
          // color: appColors.border.withOpacity(0.25),
          borderRadius: BorderRadius.circular(20.r),

          boxShadow: [
            BoxShadow(
              color: appColors.shadow.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 5,
              // offset: const Offset(10, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 120.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                appColors.blackGreenDisable.withOpacity(0.1),
                                appColors.orang.withOpacity(0.5)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                            child: (course.imageOfCourse != null &&
                                    course.imageOfCourse!.isNotEmpty)
                                ? Image.network(
                                    course.imageOfCourse!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        Images.noImage,
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    Images.noImage,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: OnBoardingContainer(
                            radius: 20.r,
                            width: 60.w,
                            height: 25.h,
                            color: course.price == 0
                                ? appColors.ok
                                : appColors.purple.withOpacity(0.9),
                            widget: Center(
                              child: AuthText(
                                text: course.price == 0
                                    ? "Free"
                                    : "${course.price}\$",
                                size: 12.sp,
                                color: const Color(0xFF1A1A2E),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthText(
                            text: course.titleOfCourse,
                            color: appColors.whiteText,
                            size: 18.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5.h),
                          AuthText(
                            text: "By ${course.teacherName}",
                            color: appColors.mainText,
                            size: 12.sp,
                            fontWeight: FontWeight.w500,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoChip(
                                  icon: Images.courses3,
                                  text: "${course.courseDuration} hours",
                                  color: appColors.cyanAccent,
                                  textColor: appColors.mainText),
                              _buildInfoChip(
                                  icon: Images.courses2,
                                  text: "${course.numberOfVideo} video",
                                  color: appColors.orang,
                                  textColor: appColors.mainText),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoChip(
                                  icon: Images.courses1,
                                  text: "${course.rate}",
                                  color: appColors.ok,
                                  textColor: appColors.mainText),
                              _buildLevelChip(course.level, appColors),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required String icon,
    required String text,
    required Color color,
    required Color textColor, // The new required parameter
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: color.withOpacity(0.4), width: 1.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                width: 15.w,
                height: 15.h,
                color: color.withOpacity(1),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: AuthText(
                  text: text,
                  color: textColor, // Use the new textColor parameter
                  fontWeight: FontWeight.w500,
                  size: 10.sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelChip(String level, ThemeState appColors) {
    Color levelColor;
    switch (level.toLowerCase()) {
      case "beginner":
        levelColor = appColors.ok;
        break;
      case "intermediate":
        levelColor = appColors.orang;
        break;
      case "advanced":
        levelColor = appColors.red;
        break;
      default:
        levelColor = appColors.lightGray;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: levelColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: levelColor.withOpacity(0.5), width: 1.w),
          ),
          child: AuthText(
            text: level.toUpperCase(),
            size: 10.sp,
            color: appColors.mainText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
