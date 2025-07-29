import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/CourseInfo/Cubit/Reveiw/review_cubit.dart';
import 'package:lms/Module/CourseInfo/Model/Review/review_response.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Reviewitem extends StatelessWidget {
  Reviewitem({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 35.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: review.yourReview ? appColors.lightGray : null,
            ),
            padding: EdgeInsets.all(20.r),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: appColors.primary,
                  radius: 25.r,
                  backgroundImage: review.student.image == null
                      ? AssetImage(Images.studentImage) as ImageProvider
                      : NetworkImage(review.student.image!) as ImageProvider,
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            child: AuthText(
                              text: review.student.name,
                              size: 14,
                              color: appColors.ok,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          RatingBarIndicator(
                            rating: review.rate.toDouble(),
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 238, 185, 26),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AuthText(
                          text: review.comment,
                          size: 10,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w400,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // 🗑️ Delete Icon
        if (review.yourReview)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                context.read<ReviewCubit>().deleteCourseReview();
              },
              child: Icon(
                Icons.delete_forever,
                color: appColors.red,
                size: 30.sp,
              ),
            ),
          ),
      ],
    );
  }
}
