import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/tap_cubit.dart';
import 'package:lms/generated/l10n.dart';

class Tap extends StatelessWidget {
  const Tap({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final selectedTab = context.watch<TapLeadercubit>().state;

    final labels = [ S.of(context).All, S.of(context).friends];

    return Container(
      width: 122.w,
      height: 50.h,
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
                onTap: () => context.read<TapLeadercubit>().changeTab(index),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? appColors.primary : appColors.secondText,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected
                          ? appColors.pageBackground
                          : appColors.pageBackground,
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
