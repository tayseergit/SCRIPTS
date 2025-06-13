import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBordingContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget widget;
  final Function()? onTap;

  const OnBordingContainer({
    super.key,
    this.width=100,
    required this.height,
    required this.color,
    required this.widget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: width.w,
        height: height.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: widget,
      ),
    );
  }
}
