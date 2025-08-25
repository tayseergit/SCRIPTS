import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseInfo/View/Pages/course_info_page.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_courses_model.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Teachercoursescard extends StatelessWidget {
  final TeacherCourse teacherCoursesModel;
  Teachercoursescard({
    super.key,
    required this.teacherCoursesModel,
  });

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
        // height: 250.h,
        color: appColors.pageBackground,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 100.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: (teacherCoursesModel.imageOfCourse == null &&
                              teacherCoursesModel.imageOfCourse.isNotEmpty)
                          ? Image.network(
                              teacherCoursesModel.imageOfCourse,
                              width: double.infinity,
                              height: 100.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  Images.noImage,
                                  width: double.infinity,
                                  height: 100.h,
                                  fit: BoxFit.contain,
                                );
                              },
                            )
                          : Image.asset(
                              Images.noImage,
                              width: double.infinity,
                              height: 100.h,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    child: OnBoardingContainer(
                      width: 40.w,
                      height: 20.h,
                      color: teacherCoursesModel.price == 0
                          ? appColors.ok
                          : appColors.orang,
                      widget: Center(
                        child: AuthText(
                          text: "${teacherCoursesModel.price} \$",
                          size: 10.sp,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              AuthText(
                text: teacherCoursesModel.titleOfCourse,
                color: appColors.mainText,
                size: 16.sp,
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  OnBoardingContainer(
                    width: 60.w,
                    height: 25.h,
                    color: appColors.darkGreen,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            Images.courses1,
                            width: 15.w,
                            height: 15.h,
                          ),
                          AuthText(
                            text: "${teacherCoursesModel.rate}",
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
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: appColors.purple,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: AuthText(
                        text: teacherCoursesModel.teacherName,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w900,
                        size: 12.sp,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              AuthText(
                text: teacherCoursesModel.level,
                size: 14.sp,
                color: teacherCoursesModel.level == "beginner"
                    ? appColors.ok
                    : teacherCoursesModel.level == "intermediate"
                        ? appColors.orang
                        : appColors.red,
                fontWeight: FontWeight.w500,
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
                        text: '${teacherCoursesModel.numberOfVideo} videos',
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
                        text: '${teacherCoursesModel.course_duration}',
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
        onTap: () {
          pushTo(
              context: context,
              toPage: CourseInfoPage(courseId: teacherCoursesModel.id));
        },
      ),
    );
  }
}
