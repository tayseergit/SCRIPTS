import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class LearnCard extends StatelessWidget {
  const LearnCard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: OnBordingContainer(
        width: 180,
        height: 250,
        color: appColors.lihgtPrimer,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                child: Image.asset(
                  Images.courses,
                  height: 90.h,
                  width: 110.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthText(
                      text: 'Web UI Best Practices',
                      size: 16,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    AuthText(
                      text: 'Advanced / 45 lessons',
                      size: 14,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    AuthText(
                      text: 'Obtained',
                      size: 14,
                      color: appColors.ok,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            AuthText(
                              text: '4.9',
                              size: 15,
                              color: appColors.secondText,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 18.h,
                        ),
                        AuthText(
                          text: '6h 30min',
                          size: 15,
                          color: appColors.secondText,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
