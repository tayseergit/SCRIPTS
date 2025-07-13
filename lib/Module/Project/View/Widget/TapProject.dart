// TapProject.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Project/View/Widget/Swich.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class TapProject extends StatelessWidget {
  const TapProject({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final selectedTab = context.watch<Swich>().state;

    final labels = ['All', 'Favorite'];

    return Container(
      width: 120.w,
      height: 50,
      decoration: BoxDecoration(
        color: appColors.secondText,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            labels.length,
            (index) {
              final isSelected = selectedTab == index;
              return GestureDetector(
                onTap: () => context.read<Swich>().changeTab(index),
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 2.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? appColors.primary
                        : appColors.secondText,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color:
                          isSelected ? appColors.pageBackground : appColors.mainText,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
