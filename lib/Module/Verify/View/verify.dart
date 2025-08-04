import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/resetPassword.dart';
import 'package:lms/Module/Auth/cubit/forget_password_cubit.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/Courses/View/Pages/courses_page.dart';
import 'package:lms/Module/NavigationBarWidged/navigationBarWidget.dart';
import 'package:lms/Module/NavigationBarWidged/navigation_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_cubit.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';
import 'package:lms/generated/l10n.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class Verify extends StatelessWidget {
  String email;
  int registretion;
  Verify({super.key, required this.email, required this.registretion});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => VerifyCubit(),
      child: BlocConsumer<VerifyCubit, VerifyState>(
        listener: (context, state) {
          print(state);
          if (state is VerifySucsses) {
            var verifyCubit = context.read<VerifyCubit>();
            registretion == 1
                ? {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: NavigationCubit(),
                            child: NavigationBarwidget(),
                          ),
                        ),
                      );
                    }),
                    Future.delayed(Duration(milliseconds: 700), () {
                      CustomSnackbar.show(
                        context: context,
                        fillColor: appColors.primary,
                        message: lang.register_completed,
                      );
                    })
                  }
                : WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: ForgetPasswordCubit(),
                          child: ResetPassword(
                            code: verifyCubit.otpController.text,
                            email: email,
                          ),
                        ),
                      ),
                      (route) => false, // Remove all previous routes
                    );
                  });
          } else if (state is VerifyErrorCode) {
            CustomSnackbar.show(
              context: context,
              duration: 7,
              fillColor: appColors.red,
              message: lang.error_code,
            );
          }
        },
        builder: (context, state) {
          var verifyCubit = VerifyCubit.get(context);
          verifyCubit.email = email;
          return Scaffold(
            backgroundColor: appColors.pageBackground,
            body: ListView(
              padding: EdgeInsets.only(top: 104),
              children: [
                Image.asset(Images.logo, height: 97.h, width: 218.w),
                SizedBox(height: 49.h),
                Align(
                  alignment: Alignment.center,
                  child: AuthText(
                    text: lang.verify_code,
                    size: 20,
                    color: appColors.mainIconColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 56.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      onCompleted: (value) {
                        verifyCubit.sendCode(
                            context: context, registration: registretion);
                      },
                      onChanged: (value) {
                        verifyCubit.isCode();
                      },
                      controller: verifyCubit.otpController,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50.h,
                        fieldWidth: 40.w,
                        activeFillColor: appColors.fieldBackground,
                        selectedColor: appColors.primary,
                        selectedFillColor: appColors.fieldBackground,
                        inactiveColor: appColors.primary,
                        inactiveFillColor: appColors.fieldBackground,
                        activeColor: appColors.primary,
                      ),
                      // backgroundColor: appColors.fieldBackground,
                      textStyle: TextStyle(
                        color: appColors.mainText,
                      ),
                      enableActiveFill: true,
                    ),
                  ),
                ),
                SizedBox(height: 45.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 50.h,
                    child: state is VerifyLoading
                        ? Center(
                            child: Loading(
                              height: 50,
                              width: 50,
                            ),
                          )
                        : OnBoardingContainer(
                            onTap: () {
                              verifyCubit.sendCode(
                                  context: context, registration: registretion);
                            },
                            width: 223,
                            height: 50,
                            color: appColors.primary,
                            widget: AuthText(
                              text: lang.send,
                              size: 20,
                              color: appColors.mainText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 54.h),
                InkWell(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.center,
                    child: AuthText(
                      text: lang.resend_code,
                      size: 18,
                      color: appColors.primary,
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
