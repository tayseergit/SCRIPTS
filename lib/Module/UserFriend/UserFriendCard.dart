import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Userfriendcard extends StatelessWidget {
  const Userfriendcard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Center(
        child: Container(
          width: 180.w,
          height: 220.h,
          decoration: BoxDecoration(
            border: Border.all(color: appColors.primary, width: 0.8),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  Image.asset(
                    Images.courses,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            appColors.mainIconColor.withOpacity(0),
                            appColors.primary.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 110.w,
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: appColors.orang, width: 3),
                            left: BorderSide(color: appColors.orang, width: 3),
                            right: BorderSide(color: appColors.orang, width: 3),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14.r),
                            bottomRight: Radius.circular(14.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Intermediate',
                            style: TextStyle(
                              color: appColors.orang,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                            color: appColors.mainText.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: appColors.primary)),
                        child: Text(
                          "Tayseer Matar",
                          style: TextStyle(
                            color: appColors.pageBackground,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
