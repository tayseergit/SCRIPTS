import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/MyLearn/SectionCubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class MainTabButton extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;

  const MainTabButton({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final isSelected = selectedIndex == index;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: InkWell(
          onTap: () => context.read<SectionCubit>().changeSection(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthText(
                text: title,
                size: 18,
                color: isSelected ?appColors.primary : appColors.secondText,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10.h),
              Divider(
                color: isSelected ?appColors.primary : appColors.secondText,
                thickness: 2,
                indent: 25,
                endIndent: 25,
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}