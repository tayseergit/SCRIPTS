import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class ContainerTest extends StatelessWidget {
  const ContainerTest({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: appColors.lihgtPrimer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.secondText),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 50,
            alignment: Alignment.center,
            child:AuthText(
              text: 'A',
              size: 13,
              color: appColors.mainText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: appColors.secondText,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: AuthText(
              text: 'Optimisation Problem',
              size: 13,
              color: appColors.mainText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
