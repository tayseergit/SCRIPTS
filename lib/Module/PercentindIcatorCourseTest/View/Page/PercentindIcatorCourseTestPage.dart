import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseTest/View/Pages/course_Test_Page.dart';
import 'package:lms/Module/CourseTest/cubit/course_test_cubit.dart';
import 'package:lms/Module/Course_content/View/Pages/course_conten_page.dart';
import 'package:lms/Module/PercentindIcatorCourseTest/View/Widget/LoadingShminer.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/generated/l10n.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentindIcatorCourseTestPage extends StatelessWidget {
  PercentindIcatorCourseTestPage({
    super.key,
    required this.courseId,
    required this.testId,
    this.message,
  });

  final int courseId;
  final int testId;
  final String? message;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return BlocProvider(
      create: (context) => CourseTestCubit(courseId: courseId, testId: testId)
        ..getCourseTest(context),
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<CourseTestCubit, CourseTestState>(
          listener: (context, state) {},
          builder: (context, state) {
            var testCubit = context.read<CourseTestCubit>();

            if (state is TestLoading) return PercentIndicatorShimmer();
            if (state is TestError)
              return Center(
                child: NoConnection(),
              );
            return Center(
              // Center everything vertically and horizontally
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AuthText(
                        maxLines: 3,
                        text: message!,
                        size: 20,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w900,
                        textAlign:
                            TextAlign.center, // <-- this centers wrapped lines
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 300.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        color: testCubit.courseTestQuestion!.bestResult >= 60
                            ? appColors.lihgtPrimer
                            : appColors.orang.withOpacity(0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthText(
                            text: lang.your_best_score,
                            size: 16,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 10.h),
                          CircularPercentIndicator(
                            animateToInitialPercent: true,
                            radius: 80.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent:
                                testCubit.courseTestQuestion!.bestResult / 100,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthText(
                                  text:
                                      '${testCubit.courseTestQuestion!.bestResult} %',
                                  size: 30,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor:
                                testCubit.courseTestQuestion!.bestResult >= 60
                                    ? appColors.lihgtPrimer
                                    : appColors.red,
                            backgroundColor: appColors.secondText,
                            widgetIndicator: Padding(
                              padding: const EdgeInsets.all(65),
                              child: Container(
                                width: 1,
                                height: 1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: appColors.pageBackground,
                                  border: Border.all(
                                      color: testCubit.courseTestQuestion!
                                                  .bestResult >=
                                              60
                                          ? appColors.lihgtPrimer
                                          : appColors.red,
                                      width: 8),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.check,
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                    AuthText(
                                      text:
                                          "${testCubit.courseTestQuestion!.correctAnswers}",
                                      size: 20,
                                      color: appColors.ok,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.close,
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                    AuthText(
                                      text:
                                          "${testCubit.courseTestQuestion!.questionCount - testCubit.courseTestQuestion!.correctAnswers}",
                                      size: 20,
                                      color: appColors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Buttons Row
                    Row(
                      children: [
                        // Restart Quiz Button
                        if (testCubit.courseTestQuestion!.bestResult < 60)
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appColors.primary,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {
                                pushReplacement(
                                  context: context,
                                  toPage: CourseTestPage(
                                    courseId: courseId,
                                    testId: testId,
                                  ),
                                );
                              },
                              child: AuthText(
                                text: lang.restart_quiz,
                                size: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (testCubit.courseTestQuestion!.bestResult < 60)
                          SizedBox(
                              width:
                                  15.w), // spacing only if both buttons exist

                        // Back Button (always appears)
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.ok,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: AuthText(
                              text: lang.back_to_video,
                              size: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
