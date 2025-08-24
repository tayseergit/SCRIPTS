import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseInfo/View/Pages/course_info_page.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/generated/l10n.dart';

class LearnInfoCard extends StatelessWidget {
  final LearnPathInfoCourse learnPathInfoCourse;
  const LearnInfoCard({super.key, required this.learnPathInfoCourse});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          colors: [
            appColors.blackGreenDisable.withOpacity(0.1),
            appColors.ok.withOpacity(0.3)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: OnBoardingContainer(
        width: 180,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: (learnPathInfoCourse.imageOfCourse != null &&
                        learnPathInfoCourse.imageOfCourse.isNotEmpty)
                    ? Image.network(
                        learnPathInfoCourse.imageOfCourse,
                        width: 110.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Images.noImage,
                            width: 110.w,
                            height: 90.h,
                            fit: BoxFit.contain,
                          );
                        },
                      )
                    : Image.asset(
                        Images.noImage,
                        width: 110.w,
                        height: 90.h,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                // ✅ الحل هنا
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthText(
                        text: learnPathInfoCourse.titleOfCourse,
                        size: 16,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          AuthText(
                            text: learnPathInfoCourse.level,
                            size: 14,
                            color: learnPathInfoCourse.level == "beginner"
                                ? appColors.ok
                                : learnPathInfoCourse.level == "intermediate"
                                    ? appColors.orang
                                    : appColors.red,
                            fontWeight: FontWeight.w400,
                          ),
                          AuthText(
                            text:
                                '/ ${learnPathInfoCourse.numberOfVideo} ${S.of(context).videos}',
                            size: 14,
                            color: appColors.secondText,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      AuthText(
                        text: learnPathInfoCourse.status ??
                            "${learnPathInfoCourse.price} \$",
                        size: 14,
                        color: appColors.ok,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.yellow, size: 21.r),
                              SizedBox(width: 5.w),
                              AuthText(
                                text: learnPathInfoCourse.rate.toString(),
                                size: 14,
                                color: appColors.secondText,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(width: 18.h),
                          AuthText(
                            text: learnPathInfoCourse.courseDuration,
                            size: 14,
                            color: appColors.secondText,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          pushTo(
              context: context,
              toPage: CourseInfoPage(courseId: learnPathInfoCourse.id));
        },
      ),
    );
  }
}
