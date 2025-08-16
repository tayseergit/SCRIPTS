import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lms/Module/ContestTest/Model/contest_test_question.dart';
import 'package:lms/Module/ContestTest/View/Widget/ContainerTest.dart';
 import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class GridViewTestAnswers extends StatelessWidget {
  GridViewTestAnswers({super.key, required this.question});
  Question question;
  @override
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return AnimationLimiter(
      key: ValueKey(question.id), // Forces rebuild when question changes
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: question.options.length,
        separatorBuilder: (_, __) => SizedBox(height: 15.h),
        itemBuilder: (ctx, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 30,
              child: FadeInAnimation(
                child: ContainerTest(
                  options: question.options[index],
                  questionId: question.id,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
