import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Courses/TapBarCubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final selectedTab = context.watch<TabCubit>().state;

    final labels = ['All', 'Enroll', 'Completed', 'Watchlater'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // حسب الحاجة
      children: List.generate(labels.length, (index) {
        final isSelected = selectedTab == index;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w),
          child: OnBordingContainer(
            width: (labels[index].length * 11).w , // زيادة بسيطة لراحة النص
            height: 40.h,
            color: isSelected ? appColors.primary : appColors.fieldBackground,
            widget: Text(
              labels[index],
              style: TextStyle(
                color: isSelected ? appColors.pageBackground : appColors.mainText,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => context.read<TabCubit>().changeTab(index),
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
    final selectedTab = context.watch<TabCubitProfile>().state;

    final labels = ['Certificates', 'Acheivement', 'My Contest', 'statices'];

    return Container(
      decoration: BoxDecoration(
        color: appColors.fieldBackground,
        borderRadius: BorderRadius.all(Radius.circular(5.r))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: List.generate(labels.length, (index) {
          final isSelected = selectedTab == index;
      
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.5.w),
            child:  OnBordingContainer(
                width: (labels[index].length *8).w , 
                height: 40.h,
                color: isSelected ? appColors.pageBackground : appColors.fieldBackground,
                widget: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? appColors.mainText : appColors.mainText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => context.read<TabCubitProfile>().changeTab(index),
              ),
            
          );
        }),
      ),
    );
  }
}
