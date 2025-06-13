import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/View/forgetPassword.dart';
import 'package:lms/Module/Auth/View/register.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Auth/View/Widget/CustomTextField.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/forget_password_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Utils/shake_animation.dart';

class ResetpasswordPage extends StatelessWidget {
  String email, code;
  int registration;
  ResetpasswordPage(
      {super.key,
      required this.email,
      required this.registration,
      required this.code});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => ForgetPasswordCubit()
        ..code.text = code
        ..emailCtrl.text = email,
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
           print(state);
          if (state is ResetPasswordSuccess) {
            FocusScope.of(context).unfocus();

             
            Future.delayed(Duration(milliseconds: 700), () {
              pushAndRemoveUntiTo(context: context, toPage: Login());
            });
          } else if (state is ResetPasswordError) {
            CustomSnackbar.show(
              context: context,
              duration: 4,
              fillColor: appColors.red,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          ForgetPasswordCubit cubit = ForgetPasswordCubit.get(context);

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
                  onChanged: (value) {
                    cubit.passwordValid(password: value);
                  },
                  controller: cubit.passWordctrl,
                  borderRadius: 5,
                  borderColor:
                      cubit.isPassWord ? appColors.border : appColors.red,
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
                  onChanged: (value) {
                    cubit.passwordConfValid(password: value);
                  },
                  controller: cubit.confirmPassWordctrl,
                  borderRadius: 5,
                  borderColor:
                      cubit.isPassWordconf ? appColors.border : appColors.red,
                  fillColor: appColors.fieldBackground,
                  textColor: appColors.mainText,
                ),
                SizedBox(height: 64.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: OnBordingContainer(
                    onTap: state is ActiveButton ? cubit.resetPassword : null,
                    width: 223,
                    height: 50,
                    color: state is ActiveButton
                        ? appColors.primary
                        : appColors.fieldBackground,
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
        },
      ),
    );
  }
}
