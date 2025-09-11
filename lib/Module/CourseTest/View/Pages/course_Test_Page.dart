import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/CourseTest/View/Widget/CourseTestLoadingShimmer%20.dart';
import 'package:lms/Module/CourseTest/View/Widget/GridViewTest.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/PercentindIcatorCourseTest/View/Page/PercentindIcatorCourseTestPage.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/CourseTest/cubit/course_test_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class CourseTestPage extends StatelessWidget {
  CourseTestPage({super.key, required this.testId, required this.courseId});
  int testId;
  int courseId;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.read<ThemeCubit>().state;
    var lang = S.of(context);
    return BlocProvider(
        create: (context) => CourseTestCubit(testId: testId, courseId: courseId)
          ..getCourseTest(context),
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          body: BlocConsumer<CourseTestCubit, CourseTestState>(
            listener: (context, state) {
              print(state);
              if (state is TestSubmitLoading) {}
              if (state is TestSubmitError) {
                customSnackBar(
                    context: context, success: 2, message: state.message);
              }
              if (state is TestSubmitSuccess) {
                // context.read<CourseContentCubit>().getCourseContent(context);

                pushReplacement(
                  context: context,
                  toPage: PercentindIcatorCourseTestPage(
                    courseId: courseId,
                    testId: testId,
                    message: state.message,
                  ),
                );
              }
              if (state is UnAuth) {
                Navigator.pop(context);
                showNoAuthDialog(context);
              }
            },
            builder: (context, state) {
              var testCubit = context.read<CourseTestCubit>();
              if (state is CourseTestInitial || state is TestLoading) {
                return CourseTestLoadingShimmer();
              }

              if (state is TestError) {
                return Center(child: NoConnection());
              }
              // WidgetsBinding.instance.addPostFrameCallback((_) {

              //   showNoAuthDialog(context);
              // });

              if (state is TestSuccess)

                // {}
                return ListView(
                  children: [
                    Container(
                      width: double.infinity.w,
                      height: 300.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r),
                          ),
                          gradient: appColors.linerContainer),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            AuthText(
                                text: lang.test,
                                size: 27,
                                color: appColors.blackGreen,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              height: 70.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthText(
                                    text:
                                        '${lang.question} ${testCubit.currentIndex + 1}',
                                    size: 15,
                                    color: appColors.red,
                                    fontWeight: FontWeight.w700),
                                OnBoardingContainer(
                                  width: 113,
                                  height: 40,
                                  color: appColors.darkGreen,
                                  widget: AuthText(
                                    text:
                                        '${testCubit.currentIndex + 1} / ${testCubit.courseTestQuestion!.test.questions.length} ${lang.question}',
                                    size: 12,
                                    color: appColors.mainText,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            AuthText(
                              text: testCubit.courseTestQuestion!.test
                                  .questions[testCubit.currentIndex].text,
                              size: 15,
                              maxLines: 4,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: GridViewTestAnswers(
                        question: testCubit.courseTestQuestion!.test
                            .questions[testCubit.currentIndex],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          // Back button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: testCubit.currentIndex > 0
                                ? (MediaQuery.of(context).size.width / 2) - 10.w
                                : 0,
                            child: testCubit.currentIndex > 0
                                ? OnBoardingContainer(
                                    key: ValueKey(
                                        "back_${testCubit.currentIndex}"),
                                    onTap: () => testCubit.previousQuestion(),
                                    height: 50,
                                    color: appColors.red,
                                    widget: AuthText(
                                      text: lang.back,
                                      size: 20,
                                      color: appColors.pageBackground,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),

                          // Small gap, only if back button is visible
                          if (testCubit.currentIndex > 0) SizedBox(width: 10.w),

                          // Next / Submit button
                          BlocConsumer<CourseTestCubit, CourseTestState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              final testCubit = context.read<CourseTestCubit>();

                              return Flexible(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  width:
                                      double.infinity, // Flexible handles width
                                  child: state is TestSubmitLoading
                                      ? Loading()
                                      : OnBoardingContainer(
                                          onTap: testCubit
                                                  .hasSelectedAnswerForCurrentQuestion
                                              ? () {
                                                  if (testCubit.currentIndex ==
                                                      testCubit
                                                              .courseTestQuestion!
                                                              .test
                                                              .questions
                                                              .length -
                                                          1) {
                                                    testCubit
                                                        .submitTest(context);
                                                  } else {
                                                    testCubit.nextQuestion();
                                                  }
                                                }
                                              : null,
                                          height: 50,
                                          color: testCubit
                                                  .hasSelectedAnswerForCurrentQuestion
                                              ? appColors.seocndIconColor
                                              : Colors.grey,
                                          widget: AuthText(
                                            text: testCubit.currentIndex ==
                                                    testCubit
                                                            .courseTestQuestion!
                                                            .test
                                                            .questions
                                                            .length -
                                                        1
                                                ? lang.submit
                                                : lang.next,
                                            size: 20,
                                            color: appColors.pageBackground,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              return Container();
            },
          ),
        ));
  }
}
