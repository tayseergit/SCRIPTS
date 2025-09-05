import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/ContestTest/View/Widget/GridViewTest.dart';
import 'package:lms/Module/ContestTest/View/Widget/contest_test_timer.dart';
import 'package:lms/Module/ContestTest/cubit/contest_test_cubit.dart';
import 'package:lms/Module/CourseTest/View/Widget/CourseTestLoadingShimmer%20.dart';
import 'package:lms/Module/PercentindIcatorContestTest/View/Page/PercentindIcatorContestTestPage.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class ContestTestPage extends StatelessWidget {
  ContestTestPage({super.key, required this.contestId});
  int contestId;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return BlocProvider(
        create: (context) =>
            ContestTestCubit(contestId: contestId)..getContestTest(context),
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          body: BlocConsumer<ContestTestCubit, ContsetTestState>(
            listener: (context, state) {
              if (state is TestSubmitError) {
                customSnackBar(
                    context: context, success: 2, message: state.message);
              }
              if (state is TestSubmitSuccess) {
                pushReplacement(
                    context: context,
                    toPage: PercentindIcatorContestTestPage(
                      contestId: contestId,
                      message: state.message,
                    ));
              }
            },
            builder: (context, state) {
              var testCubit = context.read<ContestTestCubit>();
              if (state is CourseTestInitial || state is TestLoading) {
                return CourseTestLoadingShimmer();
              }

              if (state is TestError) return Center(child: NoConnection());

              // {}
              return ListView(
                children: [
                  Container(
                    width: double.infinity.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                        gradient: appColors.linerContainer),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthText(
                                  text: lang.test,
                                  size: 27,
                                  color: appColors.mainText,
                                  fontWeight: FontWeight.w700),
                              testCubit.remainingSeconds! > 0
                                  ? ContestTestTimer(
                                      secondsLeft: testCubit.remainingSeconds!,
                                      // secondsLeft: 5,
                                      onTimeFinished: () {
                                        Navigator.of(context).pop(); // go back
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            Future.delayed(
                                                const Duration(seconds: 3), () {
                                              Navigator.of(context)
                                                  .pop(); // close dialog
                                            });
                                            return AlertDialog(
                                              backgroundColor: appColors.orang,
                                              title: AuthText(
                                                  textAlign: TextAlign.center,
                                                  text: lang
                                                      .Timeisfinishedtocopmletetest,
                                                  size: 15.sp,
                                                  color: appColors.mainText,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
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
                                      '${testCubit.currentIndex + 1} / ${testCubit.contestTestQuestion!.questions.length}',
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
                            text: testCubit.contestTestQuestion!
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
                      question: testCubit.contestTestQuestion!
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
                        Flexible(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: double.infinity, // Flexible handles width
                            child: OnBoardingContainer(
                              onTap:
                                  testCubit.hasSelectedAnswerForCurrentQuestion
                                      ? () {
                                          if (testCubit.currentIndex ==
                                              testCubit.contestTestQuestion!
                                                      .questions.length -
                                                  1) {
                                            testCubit.submitTest(context);
                                          } else {
                                            testCubit.nextQuestion();
                                          }
                                        }
                                      : null,
                              height: 50,
                              color:
                                  testCubit.hasSelectedAnswerForCurrentQuestion
                                      ? appColors.seocndIconColor
                                      : Colors.grey,
                              widget: AuthText(
                                text: testCubit.currentIndex ==
                                        testCubit.contestTestQuestion!.questions
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
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
