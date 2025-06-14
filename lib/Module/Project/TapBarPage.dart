import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Project/TapBarCubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';

class TabButtonsProject extends StatelessWidget {
  const TabButtonsProject({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final selectedTab = context.watch<TapbarcubitProject>().state;

    final labels = ['All', 'Web', 'Mobile', 'AI', 'Data', 'Favorite'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          labels.length,
          (index) {
            final isSelected = selectedTab == index;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
              child: OnBoardingContainer(
                width: (labels[index].length * 15).w,
                height: 40.h,
                color:
                    isSelected ? appColors.primary : appColors.fieldBackground,
                widget: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected
                        ? appColors.pageBackground
                        : appColors.mainText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () =>
                    context.read<TapbarcubitProject>().changeTab(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
