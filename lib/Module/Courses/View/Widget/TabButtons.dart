// lib/Module/Courses/widget/tab_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Courses/View/Widget/TapBarCubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.watch<TabCubit>().state;
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        final labels = ['All', 'Enroll', 'Completed', 'Watchlater'];
        final isSelected = selectedTab == index;

        return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnBordingContainer(
              width: (labels[index].length * 11).w,
              height: 40.h,
              color: isSelected ? appColors.primary : appColors.fieldBackground,
              widget: Text(labels[index]),
              onTap: () => context.read<TabCubit>().changeTab(index),
            ),
          ),
        );
      }),
    );
  }
}
