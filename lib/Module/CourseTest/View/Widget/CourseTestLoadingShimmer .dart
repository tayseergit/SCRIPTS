import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CourseTestLoadingShimmer extends StatelessWidget {
  const CourseTestLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView(
        children: [
          // Top Container
          Container(
            width: double.infinity,
            height: 300.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              color: Colors.white,
            ),
          ),
          SizedBox(height: 60.h),

          // Answer boxes placeholder
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  height: 50.h,
                  width: double.infinity,
                  color: Colors.white,
                );
              }),
            ),
          ),

          SizedBox(height: 30.h),

          // Next button placeholder
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Container(
              height: 50.h,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
