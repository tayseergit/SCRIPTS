import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:lms/Module/CourseTest/Model/course_test_question.dart';
import 'package:lms/Module/CourseTest/cubit/course_test_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class ContainerTest extends StatelessWidget {
  ContainerTest({super.key, required this.options, required this.questionId});
  Option options;
  int questionId;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return OnBoardingContainer(
      onTap: () {
        context.read<CourseTestCubit>().selectAnswer(questionId, options.id);
        print(context.read<CourseTestCubit>().answers[questionId.toString()]);
        print(options.id);
      },
      height: 60.h,
      color: context.read<CourseTestCubit>().answers[questionId.toString()] ==
              options.id
          ? appColors.lightGray
          : appColors.blackGreenDisable,
      // boarderColor: appColors.blackGreen,
      radius: 20,
      widget: AuthText(
        text: options.answer,
        maxLines: 3,
        size: 13,
        color: appColors.mainText,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
