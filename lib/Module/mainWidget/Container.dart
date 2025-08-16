import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class OnBoardingContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? boarderColor;
  final Widget widget;
  final Function()? onTap;

  const OnBoardingContainer({
    super.key,
    this.width,
    this.height,
    this.boarderColor,
    this.color,
    required this.widget,
    this.onTap,
    this.radius = 5,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width?.w,
        height: height?.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: boarderColor ?? appColors.border.withOpacity(0)),
          color: color,
          borderRadius: BorderRadius.circular(radius!.r),
        ),
        child: widget,
      ),
    );
  }
}

class OnBoardingContainerMore extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color? borderColor;
  final Widget widget;
  final Function()? onTap;

  const OnBoardingContainerMore({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.widget,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: width.w,
        height: height.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.r,),
          border: Border.all(color: borderColor ?? appColors.border.withOpacity(0))
        ),
        child: widget,
      ),
    );
  }
}
