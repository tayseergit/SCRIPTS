import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class TabButtonsss extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onTabChange;

  const TabButtonsss({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(labels.length, (index) {
        final isSelected = selectedIndex == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnBordingContainer(
              width: double.infinity,
              height: 40.h,
              color: isSelected ? appColors.primary : appColors.fieldBackground,
              widget: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected ? appColors.pageBackground : appColors.mainText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => onTabChange(index),
            ),
          ),
        );
      }),
    );
  }
}
