import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart' show ThemeState;
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Profilestate extends StatelessWidget {
  final String title;
  final String value;
  const Profilestate({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appColors.primary),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OnBoardingContainer(
        width: 80,
        height: 40,
        color: appColors.pageBackground,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthText(
              text: title,
              size: 8,
              color: appColors.mainText,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 2.h),
            AuthText(
              text: value,
              size: 15,
              color: appColors.mainText,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
