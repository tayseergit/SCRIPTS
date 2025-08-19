import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ListViewContainer extends StatelessWidget {
  final String name;
  final String score;
  final String rank;
  final Color rankColor;
  final BorderRadius borderRadius;
  final Widget image;
  final double height;
  final BoxBorder border;

  const ListViewContainer({
    super.key,
    required this.name,
    required this.score,
    required this.rank,
    required this.rankColor,
    required this.borderRadius,
    required this.image,
    required this.height,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 110.w,
          height: height,
          decoration: BoxDecoration(
            color: appColors.border,
            borderRadius: borderRadius,
            border: border,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 50.h),
              Text(
                name,
                style: TextStyle(
                  color: appColors.mainText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                score,
                style: TextStyle(
                  color: rankColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        Positioned(
          top: -50.h,
          child: CircleAvatar(
            radius: 35.r,
            backgroundColor: appColors.pageBackground,
            child: ClipOval(
              child: image,
            ),
          ),
        ),
        Positioned(
          top: 15.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: rankColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              rank,
              style: TextStyle(
                color: appColors.pageBackground,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
