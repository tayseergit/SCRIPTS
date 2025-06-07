// lib/Module/Courses/widget/tab_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Courses/TapBarCubit.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.watch<TabCubit>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        final labels = ['All', 'Enroll', 'Completed', 'Watchlater'];
        final isSelected = selectedTab == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnBordingContainer(
              width: double.infinity,
              height: 40.h,
              color: isSelected ? AppColors.primary : Colors.grey[100]!,
              widget: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => context.read<TabCubit>().changeTab(index),
            ),
          ),
        );
      }),
    );
  }
}
