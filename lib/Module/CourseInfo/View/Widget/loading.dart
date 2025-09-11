import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:shimmer/shimmer.dart';

class CourseInfoLoadingShimmer extends StatelessWidget {
  const CourseInfoLoadingShimmer({super.key});

  Widget shimmerBox(
      {double height = 20,
      double width = double.infinity,
      BorderRadius? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius ?? BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      color: appColors.pageBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Top image
          shimmerBox(height: 300.h, radius: BorderRadius.zero),

          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and level
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shimmerBox(width: 200.w, height: 20.h),
                    shimmerBox(width: 60.w, height: 30.h),
                  ],
                ),
                SizedBox(height: 10.h),

                // Info row
                shimmerBox(width: 250.w, height: 15.h),
                SizedBox(height: 20.h),

                // Reviews section
                shimmerBox(width: 100.w, height: 20.h),
                SizedBox(height: 10.h),
                shimmerBox(width: double.infinity, height: 100.h),

                SizedBox(height: 20.h),

                // About this course
                shimmerBox(width: 150.w, height: 20.h),
                SizedBox(height: 10.h),
                shimmerBox(width: double.infinity, height: 60.h),

                SizedBox(height: 20.h),
                Divider(),

                // Mentor Section
                Center(child: shimmerBox(width: 100.w, height: 20.h)),
                SizedBox(height: 10.h),
                Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(child: shimmerBox(width: 100.w, height: 15.h)),
                // Center(child: shimmerBox(width: 150.w, height: 10.h)),
                // Center(child: shimmerBox(width: 60.w, height: 10.h)),

                SizedBox(height: 15.h),
                shimmerBox(height: 40.h),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
