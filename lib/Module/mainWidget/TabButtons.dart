import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({
    super.key,
    required this.labels,
    required this.selectedTab,
    required this.onTap,
  });

  final List<String> labels;
  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        final label = labels[index];
        final isSelected = selectedTab == index;

        return Flexible(
          flex: label.length,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: OnBoardingContainer(
              height: 40.h,
              color: isSelected ? appColors.primary : appColors.fieldBackground,
              widget: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? appColors.pageBackground
                        : appColors.mainText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () => onTap(index),
            ),
          ),
        );
      }),
    );
  }
}

class TabButtonsProfile extends StatelessWidget {
  const TabButtonsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeState appColors = context.watch<ThemeCubit>().state;
    final StudentProfileCubit studentProfileCubit =
        context.watch<StudentProfileCubit>();

    final labels = studentProfileCubit.getLabels(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = studentProfileCubit.selectedTab == index;
          final label = labels[index];

          // Wrap each tab in Expanded so they share space equally
          return Expanded(
            child: InkWell(
              onTap: () => studentProfileCubit.changeTab(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      fontSize: isSelected ? 16.sp : 14.sp,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w300,
                      color: appColors.mainText,
                    ),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 2.h,
                    width: isSelected ? 20.w : 0,
                    color: appColors.primary,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
