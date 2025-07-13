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
    ThemeState appColors = context.watch<ThemeCubit>().state;
    StudentProfileCubit studentProfileCubit =
        context.watch<StudentProfileCubit>();

    return Container(
      decoration: BoxDecoration(
          color: appColors.pageBackground,
          borderRadius: BorderRadius.all(Radius.circular(5.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(studentProfileCubit.labels.length, (index) {
          final isSelected = studentProfileCubit.selectedTab == index;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.5.w),
            child: OnBoardingContainer(
              width: (studentProfileCubit.labels[index].length * 10).w,
              height: 40.h,
              color: isSelected
                  ? appColors.pageBackground
                  : appColors.fieldBackground,
              widget: Text(
                studentProfileCubit.labels[index],
                style: TextStyle(
                  color: isSelected ? appColors.mainText : appColors.mainText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => studentProfileCubit.changeTab(index),
            ),
          );
        }),
      ),
    );
  }
}
