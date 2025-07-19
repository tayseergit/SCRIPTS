import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Project/Cubit/project_cubit.dart';
import 'package:lms/Module/Project/View/Widget/TapBarCubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class TabButtonsProject extends StatelessWidget {
  TabButtonsProject({super.key, required this.cubit});
  ProjectCubit cubit;
  @override
  Widget build(BuildContext context) {
     final appColors = context.watch<ThemeCubit>().state;
    final labels = cubit.tagResponse!.tags;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: appColors.lightGray,
        borderRadius: BorderRadius.circular(5.r),
      ),
      height: 45.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final isSelected = cubit.selectedTab == index;

          return GestureDetector(
            onTap: () => cubit.changeTab(index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color:
                    isSelected ? appColors.pageBackground : Colors.transparent,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: Text(
                  labels[index].name,
                  style: TextStyle(
                    color: appColors.mainText,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
