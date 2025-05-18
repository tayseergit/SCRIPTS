import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Auth/Widget/CustomTextField.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/app_color_cubit.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newpassword = TextEditingController();
    final TextEditingController confirmNewPassword = TextEditingController();
    return Scaffold(
      backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
      body: ListView(
        padding: EdgeInsets.only(top: 85, left: 19, right: 19),
        children: [
          Image.asset('assets/images/image.png', height: 150.h, width: 150.w),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Forget Password ',
              size: 18,
              coloer: Appcolors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 54.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'New Password',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: newpassword,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),
          SizedBox(height: 50.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Confirm Password',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: confirmNewPassword,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),
          SizedBox(height: 64.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: OnBordingContainer(
              width: 223,
              height: 50,
              color: Appcolors.primary,
              widget: AuthText(
                text: 'Reset Password',
                size: 20,
                coloer: Appcolors.textprem,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
