import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/forget_password_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key, required this.code, required this.email});
  String code;
  String email;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return BlocProvider(
      create: (context) => ForgetPasswordCubit()..otpController.text = code ..emailctrl.text=email,
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            var resetCubit = context.read<ForgetPasswordCubit>();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: AuthCubit(),
                  child: Login(),
                ),
              ),
              (route) => false,
            );

            // Future.delayed(Duration(milliseconds: 700), () {
            //   customSnackBar(
            //       context: context,
            //       success: 1,
            //       message: lang.reset_password_done);
            // });
          }
        },
        builder: (context, state) {
          var cubit = context.read<ForgetPasswordCubit>();
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
                    text: lang.forget_password,
                    size: 18,
                    color: appColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 54.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AuthText(
                    text: lang.newPassword,
                    color: appColors.secondText,
                    size: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                CustomTextField(
                  onChanged: (value) => cubit.passwordValid(password: value),
                  controller: cubit.passwordctrl,
                  obscureText: true,
                  toggleObscure: true,
                  borderRadius: 5,
                  borderColor:
                      cubit.isPassWord ? appColors.pageBackground : Colors.red,
                  fillColor: appColors.fieldBackground,
                  textColor: appColors.mainText,
                ),
                SizedBox(height: 10.h),
                !cubit.isEmail
                    ? AuthText(
                        text: lang.at_least_8_char_lower_upper_symbols,
                        color: Colors.red,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      )
                    : Container(),
                SizedBox(height: 50.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AuthText(
                    text: lang.confirmNewPassword,
                    color: appColors.secondText,
                    size: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                CustomTextField(
                  onChanged: (value) => cubit.passwordValid(password: value),
                  controller: cubit.confirmPasswordCtrl,
                  obscureText: true,
                  toggleObscure: true,
                  borderRadius: 5,
                  borderColor:
                      cubit.isPassWord ? appColors.pageBackground : Colors.red,
                  fillColor: appColors.fieldBackground,
                  textColor: appColors.mainText,
                ),
                SizedBox(height: 10.h),
                !cubit.isPassWordconf
                    ? AuthText(
                        text: lang.at_least_8_char_lower_upper_symbols,
                        color: Colors.red,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      )
                    : Container(),
                SizedBox(height: 64.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: state is SendCodeLoading
                      ? Center(
                          child: Loading(
                            height: 50,
                            width: 50,
                          ),
                        )
                      : OnBoardingContainer(
                          width: 223,
                          height: 50,
                          color: appColors.primary,
                          widget: AuthText(
                            text: lang.resetPassword,
                            size: 18,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700,
                          ),
                          onTap: () {
                            cubit.resetPassword(context);
                          },
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
