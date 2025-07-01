import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/PercentIndicator/GridViewPercent.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Percentindicatorpage extends StatelessWidget {
  const Percentindicatorpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        children: [
          Container(
            width: double.infinity.w,
            height: 300.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: appColors.lihgtPrimer,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthText(
                  text: 'Your Score',
                  size: 16,
                  color: appColors.mainText,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CircularPercentIndicator(
                  animateToInitialPercent: true,
                  radius: 80.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: 1,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthText(
                        text: '70%',
                        size: 30,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                      AuthText(
                        text: 'Good',
                        size: 14,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  arcType: ArcType.FULL,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: appColors.blue,
                  backgroundColor: appColors.secondText,
                  widgetIndicator: Padding(
                    padding: const EdgeInsets.all(65),
                    child: Container(
                      width: 1,
                      height: 1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appColors.pageBackground,
                        border: Border.all(color: appColors.blue, width: 8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Images.check,
                            width: 50.w,
                            height: 50.h,
                          ),
                          AuthText(
                            text: '18',
                            size: 20,
                            color: appColors.ok,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Images.close,
                            width: 50.w,
                            height: 50.h,
                          ),
                          AuthText(
                            text: '20',
                            size: 20,
                            color: appColors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          Gridviewpercent()
        ],
      ),
    );
  }
}
