import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Helper/global_func.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_profile_model.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/generated/l10n.dart';

class MainHeader extends StatelessWidget {
  final UserData user;

  const MainHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 300.h,
      child: Row(
        children: [
          // Profile Image Container
          Expanded(
            child: Container(
              // height: 300.h,
              // width: 180.w,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30.r)),
                color: appColors.primary,
              ),
              padding: EdgeInsets.all(8.w),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: ClipOval(
                    child: user.image == null
                        ? Image.asset(
                            // color: appColors.pageBackground,
                            Images.noProfile,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            user.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(Images.noProfile,
                                    fit: BoxFit.cover),
                          ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Profile Info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthText(
                  text: user.name ?? "",
                  size: 18.sp,
                  color: appColors.mainText,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10.h),
                AuthText(
                  text: user.email ?? "",
                  size: 12.sp,
                  color: appColors.secondText,
                ),
                SizedBox(height: 10.h),
                AuthText(
                  text: user.joined ?? "",
                  size: 12.sp,
                  color: appColors.secondText,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(Icons.school,
                        size: 14.sp, color: appColors.orang.withOpacity(0.8)),
                    SizedBox(width: 4.w),
                    AuthText(
                      text: S.of(context).teacher,
                      size: 12.sp,
                      color: appColors.orang,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                OnBoardingContainer(
                  onTap: () {
                    if (user.gitHubAccount != null) {
                      GlobalFunc.launchURL(user.gitHubAccount!);
                    }
                  },
                  widget: Row(
                    children: [
                      Image.asset(
                        Images.github,
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      AuthText(
                        text: 'GitHub Account',
                        size: 12.sp,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                if (user.balance != null)
                  Row(
                    children: [
                      Icon(Icons.wallet_outlined,
                          size: 28.sp, color: appColors.mainIconColor),
                      SizedBox(width: 4.w),
                      Container(
                        width: 120.w,
                        child: AuthText(
                          text: "${user.balance ?? ""} \$",
                          size: 20.sp,
                          color: appColors.ok,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
