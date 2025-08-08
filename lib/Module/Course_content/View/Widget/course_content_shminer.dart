import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CourseContentShimmer extends StatelessWidget {
  const CourseContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Video Placeholder
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: 300.h,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20.h),

        // Title row placeholder
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Row(
            children: [
              shimmerBox(width: 40.w, height: 24.h),
              SizedBox(width: 10.w),
              shimmerBox(width: 200.w, height: 24.h),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // Subtitle placeholder
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: shimmerBox(width: double.infinity, height: 15.h),
        ),
        SizedBox(height: 20.h),

        // Comments placeholder
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: shimmerBox(width: double.infinity, height: 120.h),
        ),
        SizedBox(height: 20.h),

        // Grid placeholder (3 items)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: List.generate(
              3,
              (index) => shimmerBox(width: 110.w, height: 80.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
