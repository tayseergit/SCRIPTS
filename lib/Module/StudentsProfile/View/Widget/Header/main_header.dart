import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class MainHeader extends StatelessWidget {
  final StudentProfileCubit cubit;

  const MainHeader({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Container(
      decoration: BoxDecoration(
        // color: appColors.lightGray,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.r),
          bottomRight: Radius.circular(25.r),
        ),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Expanded(
            child: Container(
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30.r)),
                color: appColors.primary.withOpacity(1),
              ),
              padding: EdgeInsets.all(4.w),
              child: Container(
                height: 70.h,
                width: 70.w,
                child: ClipOval(
                  child: cubit.studentProfileModel.image == null
                      ? Image.asset(
                          Images.noProfile,
                          width: 70.w,
                          height: 70.w,
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          cubit.studentProfileModel.image!,
                          width: 70.w,
                          height: 70.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(Images.noProfile,
                                  width: 70.w, height: 70.w, fit: BoxFit.cover),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Profile Info
          Expanded(
            child: Container(
              // height: 300.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthText(
                    text: cubit.studentProfileModel.name,
                    size: 18,
                    color: appColors.mainText,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 25.h),
                  AuthText(
                    text: cubit.studentProfileModel.email,
                    size: 10,
                    color: appColors.secondText,
                  ),
                  SizedBox(height: 25.h),
                  AuthText(
                    text: cubit.studentProfileModel.joined,
                    size: 12,
                    color: appColors.secondText,
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Icon(Icons.school,
                          size: 14, color: appColors.orang.withOpacity(0.8)),
                      SizedBox(width: 4.w),
                      AuthText(
                        text: cubit.studentProfileModel.level,
                        size: 12,
                        color: appColors.orang,
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  OnBoardingContainer(
                      widget: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Image.asset(
                          Images.github,
                          height: 20.h,
                          width: 20.w,
                          // color: appColors.lightGray,
                        ),
                        SizedBox(width: 15.w),
                        AuthText(
                          text: 'GitHub Account',
                          size: 12,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),
                      ])),
                  SizedBox(height: 25.h),
                  cubit.studentProfileModel.balance != null
                      ? Row(
                          children: [
                            Icon(Icons.wallet_outlined,
                                size: 28, color: appColors.mainIconColor),
                            SizedBox(width: 4.w),
                            AuthText(
                              text:
                                  "${cubit.studentProfileModel.balance ?? ""} \$",
                              size: 20,
                              color: appColors.ok,
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
