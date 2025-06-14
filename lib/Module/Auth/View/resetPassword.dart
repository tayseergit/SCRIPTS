import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newpassword = TextEditingController();
    final TextEditingController confirmNewPassword = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        padding: EdgeInsets.only(top: 85, left: 19, right: 19),
        children: [
          Image.asset(Images.logo, height: 150.h, width: 150.w),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Forget Password ',
              size: 18,
              color: appColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 54.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'New Password',
              color: appColors.secondText,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: newpassword,
            borderRadius: 5,
            borderColor: appColors.border,
            fillColor: appColors.fieldBackground,
            textColor: appColors.mainText,
          ),
          SizedBox(height: 50.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Confirm Password',
              color: appColors.secondText,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: confirmNewPassword,
            borderRadius: 5,
            borderColor: appColors.border,
            fillColor: appColors.fieldBackground,
            textColor: appColors.mainText,
          ),
          SizedBox(height: 64.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: OnBoardingContainer(
              width: 223,
              height: 50,
              color: appColors.primary,
              widget: AuthText(
                text: 'Reset Password',
                size: 18,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
