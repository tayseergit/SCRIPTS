import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';

class Cursescard extends StatelessWidget {
  const Cursescard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OnBordingContainer(
        width: 180,
        height: 260, // Slightly increased height
        color: AppColors.white,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Images.courses,
                      width: 165,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 3,
                    left: 3,
                    child: OnBordingContainer(
                      width: 35,
                      height: 18,
                      color: AppColors.ok,
                      widget: AuthText(
                        text: 'Free',
                        size: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              AuthText(
                text: 'Vue js',
                color: AppColors.black,
                size: 20,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.h),
              
              // Adjusted Row with spacing and height
              SizedBox(
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OnBordingContainer(
                      width: 40,
                      height: 25, // Increased height
                      color: AppColors.darkGreen,
                      widget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(Images.courses1),
                            AuthText(
                              text: '5.0',
                              color: AppColors.black,
                              fontWeight: FontWeight.w900,
                              size: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    OnBordingContainer(
                      width: 70,
                      height: 25,
                      color: AppColors.lihgtPrimer,
                      widget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Center(
                          child: AuthText(
                            text: 'Tayseer Matar',
                            color: AppColors.black,
                            fontWeight: FontWeight.w900,
                            size: 8,
                          ),
                        ),
                      ),
                    ),
                    AuthText(
                      text: 'Beginner',
                      size: 10,
                      color: AppColors.ok,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.courses2,
                        height: 19.h,
                        width: 19.w,
                        color: AppColors.blue,
                      ),
                      SizedBox(width: 5),
                      AuthText(
                        text: '30 vedio',
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        size: 13,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Images.courses3,
                        width: 19.w,
                        height: 19.h,
                        color: AppColors.blue,
                      ),
                      SizedBox(width: 3),
                      AuthText(
                        text: '40 Hours',
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        size: 13,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
