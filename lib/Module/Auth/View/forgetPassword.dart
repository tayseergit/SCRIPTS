import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/resetPassword.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Auth/View/Widget/CustomTextField.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/forget_password_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Verify/View/verify.dart';
import 'package:lms/Utils/loading.dart';
import 'package:lms/Utils/shake_animation.dart';

class ForgetpasswordPage extends StatelessWidget {
  const ForgetpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            ForgetPasswordCubit cubit = ForgetPasswordCubit.get(context);

            if (state is SendEmailSuccess) {
              pushTo(
                  context: context,
                  toPage: VerifyPage(
                    email: cubit.emailCtrl.text,
                    registration: 0,
                  ));

              Future.delayed(Duration(milliseconds: 700), () {
                CustomSnackbar.show(
                  context: context,
                  fillColor: appColors.ok,
                  message: "Code sended",
                );
              });
            } else if (state is SendEmailError) {
              CustomSnackbar.show(
                context: context,
                fillColor: appColors.ok,
                message: state.message,
              );
            }
          },
          builder: (context, state) {
            ForgetPasswordCubit cubit = ForgetPasswordCubit.get(context);
            return ListView(
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
                  onChanged: (value) {
                    cubit.validEmail(value);
                  },
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  borderRadius: 5,
                  borderColor: cubit.isEmail ? appColors.border : appColors.red,
                  fillColor: appColors.fieldBackground,
                  textColor: appColors.mainText,
                ),
                state is IsNotEmail
                    ? AuthText(
                        text: 'Invalid Email',
                        color: appColors.red,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      )
                    : Container(),
                SizedBox(height: 69.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: SizedBox(
                    height: 50.h,
                    child: state is SendEmailLoading
                        ? Center(
                            child: Loading(
                              height: 50,
                              width: 50,
                            ),
                          )
                        : OnBordingContainer(
                            width: 223,
                            height: 50,
                            color: state is IsEmail
                                ? appColors.primary
                                : appColors.fieldBackground,
                            widget: AuthText(
                              text: 'Send a code',
                              size: 18,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w700,
                            ),
                            onTap: () {
                              state is IsEmail ? cubit.sendEmail() : null;
                            },
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
