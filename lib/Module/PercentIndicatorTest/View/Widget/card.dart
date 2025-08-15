import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/PercentIndicatorTest/View/Widget/GredViewQuestion.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class CardPercent extends StatelessWidget {
  const CardPercent({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        AuthText(
          text: 'Question 1',
          size: 18,
          color: appColors.red,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          height: 10.h,
        ),
        AuthText(
          text:
              'Created by our expert for upcoming exam, so attempt the test and check your preprations....',
          size: 14,
          color: appColors.mainText,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 10.h,
        ),
        Gredviewquestion(),
      ],
    );
  }
}
