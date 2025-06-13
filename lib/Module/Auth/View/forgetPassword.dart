import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/resetPassword.dart';
 
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        padding: EdgeInsets.only(top: 85, left: 19, right: 19),
        children: [
          Image.asset(Images.logo, height: 153.h, width: 114.w),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Forget Password ',
              size: 18,
              color: appColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 77.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Email',
              color: appColors.secondText,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5,
            borderColor: appColors.border,
            fillColor: appColors.fieldBackground,
            textColor: appColors.mainText,
          ),
          SizedBox(height: 69.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: OnBordingContainer(
              width: 223,
              height: 50,
              color: appColors.primary,
              widget: AuthText(
                text: 'Send a code',
                size: 18,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
              onTap: () {
                pushReplacement(context: context, toPage: Resetpassword());
              },
            ),
          ),
        ],
      ),
    );
  }
}
