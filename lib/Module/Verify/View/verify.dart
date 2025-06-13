import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/appColors.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/pusher.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/View/resetPassword.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_cubit.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_state.dart';
import 'package:lms/Utils/loading.dart';
import 'package:lms/Utils/shake_animation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPage extends StatelessWidget {
  String email;
  int registration;
  VerifyPage({super.key, required this.email, required this.registration});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => VerifyCubit(),
      child: BlocConsumer<VerifyCubit, VerifyState>(
        listener: (context, state) {
          print(state);
          if (state is VerifySucsses) {
            var verifyCubit = VerifyCubit.get(context);

            registration == 1
                ? pushAndRemoveUntil(context: context, toPage: Login())
                : pushTo(
                    context: context,
                    toPage: ResetpasswordPage(
                        email: email,
                        registration: registration,
                        code: verifyCubit.otpController.text));

            FocusScope.of(context)
                .unfocus(); // Add this to remove keyboard focus

            Future.delayed(Duration(milliseconds: 700), () {
              CustomSnackbar.show(
                context: context,
                fillColor: appColors.primary,
                message: "Completed",
              );
            });
          } else if (state is VerifyErrorCode) {
            CustomSnackbar.show(
              context: context,
              duration: 7,
              fillColor: appColors.red,
              message: "Error Code",
            );
          } else if (state is VerifyErrorConnection) {
            CustomSnackbar.show(
              context: context,
              duration: 7,
              fillColor: appColors.red,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          var verifyCubit = VerifyCubit.get(context);
          verifyCubit.email = email;
          verifyCubit.registration = registration;
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
                    text: 'Verify Code',
                    size: 20,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 56.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: PinCodeTextField(
                    onCompleted: (value) {
                      registration == 1
                          ? verifyCubit.sendCode(isRegistration: true)
                          : verifyCubit.sendCode(isRegistration: false);
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
                    backgroundColor: appColors.fieldBackground,
                    textStyle: TextStyle(
                      color: appColors.mainText,
                    ),
                    enableActiveFill: false,
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
                        : OnBordingContainer(
                            onTap: () {
                              registration == 1
                                  ? verifyCubit.sendCode(isRegistration: true)
                                  : verifyCubit.sendCode(isRegistration: false);
                            },
                            width: 223,
                            height: 50,
                            color: appColors.primary,
                            widget: AuthText(
                              text: 'Send',
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
                      text: 'resend code ?',
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
