import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseTest/View/Pages/course_Test_Page.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_state.dart';
import 'package:lms/Module/Course_content/Cubit/VideoCubit/VideoCubit.dart';
import 'package:lms/Module/Course_content/Model/ContentModel/course_content_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/generated/l10n.dart';

class TestCourseCard extends StatelessWidget {
  final ContentItem testItem;
  final int courseId;
  TestCourseCard({Key? key, required this.testItem, required this.courseId});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocBuilder<CourseContentCubit, CourseContentState>(
      builder: (context, state) {
        // Use the updated item from cubit state
        final updatedItem = context
            .read<CourseContentCubit>()
            .courseContentResponse!
            .data!
            .allContents
            .firstWhere((e) => e.id == testItem.id);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0.h),
          child: InkWell(
            onTap: () {
              // pause video if needed
              final youtubeController =
                  context.read<VideoCubit>().youtubeController;
              youtubeController?.pause();

              if (!testItem.completed!) {
                // <- use updatedItem here
                pushTo(
                  context: context,
                  toPage: CourseTestPage(
                    testId: testItem.id,
                    courseId: courseId,
                  ),
                );
              }
            },
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: appColors.fieldBackground,
                border: Border.all(color: appColors.border),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                child: Row(
                  children: [
                    // Test icon
                    Container(
                        height: 60.h,
                        width: 60.w,
                        child: Image.asset(Images.TestImage)),
                    SizedBox(width: 12.w),

                    // Texts: order, title, status
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                text: testItem.order
                                    .toString()
                                    .padLeft(2, '0'), // <- updated
                                size: 20,
                                color: appColors.secondText,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 6.w),
                              AuthText(
                                text: S.of(context).Quiz,
                                size: 16,
                                color: appColors.purple,
                                fontWeight: FontWeight.w700,
                              ),
                              AuthText(
                                text: testItem.completed!
                                    ? S.of(context).Completed
                                    : S.of(context).Not_Completed,
                                size: 12,
                                color: testItem.completed!
                                    ? appColors.ok
                                    : appColors.red,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 2.w),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AuthText(
                                  text: testItem.title, // <- updated
                                  size: 16,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Completion icon
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        testItem.completed!
                            ? Icons.done
                            : Icons.play_circle_fill_outlined,
                        color: testItem.completed!
                            ? appColors.ok
                            : appColors.orang,
                        size: 50.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
