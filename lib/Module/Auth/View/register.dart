import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_cubit.dart';
import 'package:lms/Module/Verify/View/verify.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Utils/loading.dart';
import 'package:lms/Utils/shake_animation.dart';

class Register extends StatelessWidget {
  Register({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      color: appColors.primary,
      child: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            final authCubit = AuthCubit.get(context);
            if (state is SignUpSuccess) {
              CustomSnackbar.show(
                fillColor: appColors.ok,
                context: context,
                message: "Check your email for code",
              );
              // Then navigate
              pushTo(
                  context: context,
                  toPage: Verify(email: authCubit.emailRegCtrl.text));
            } else if (state is SignUpError) {
              CustomSnackbar.show(
                context: context,
                duration: 7,
                fillColor: appColors.red,
                message: state.message,
              );
            }
          },
          builder: (context, state) {
            AuthCubit authCubit = AuthCubit.get(context);
            return Scaffold(
              backgroundColor: appColors.pageBackground,
              body: ListView(
                padding: EdgeInsets.only(top: 5.h, left: 19.w, right: 19.w),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthText(
                          text: 'En',
                          color: appColors.mainText,
                          size: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        AuthText(
                          text: 'Register',
                          color: appColors.primary,
                          size: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                          child: SvgPicture.asset(
                            context.watch<ThemeCubit>().state.isDarkMode
                                ? Images.lightmode
                                : Images.darkmode,
                            width: 25.w,
                            height: 25.h,
                            // ignore: deprecated_member_use
                            color: appColors.mainText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: 3.95.r,
                        child: SizedBox(
                          width: 120.w,
                          height: 120.h,
                          child: CircularProgressIndicator(
                            value: 0.80.r,
                            strokeWidth: 8.r,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              appColors.primary,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: null,
                        child:
                            Icon(Icons.person, size: 40.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 110),
                    child: OnBordingContainer(
                      width: 100,
                      height: 40,
                      color: appColors.primary,
                      widget: AuthText(
                        text: 'Add image',
                        color: appColors.mainText,
                        size: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: appColors.border, width: 1.5.w),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: OnBordingContainer(
                          width: 170,
                          height: 50,
                          color: appColors.fieldBackground,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.google,
                                height: 20.h,
                                width: 20.w,
                                color: appColors.mainText,
                              ),
                              SizedBox(width: 15.w),
                              AuthText(
                                text: 'Google',
                                color: appColors.mainText,
                                size: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 8.w,
                          ), // Optional spacing between buttons
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appColors.border,
                              width: 1.5.w,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: OnBordingContainer(
                            height: 50.h,
                            color: appColors.fieldBackground,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.github,
                                  height: 20.h,
                                  width: 20.w,
                                  color: appColors.mainText,
                                ),
                                SizedBox(width: 15.w),
                                AuthText(
                                  text: 'GitHub',
                                  color: appColors.mainText,
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                      text: 'Name',
                      color: appColors.secondText,
                      size: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    controller: authCubit.nameCtrl,
                    borderRadius: 5,
                    borderColor: appColors.border,
                    fillColor: appColors.fieldBackground,
                    textColor: appColors.mainText,
                  ),
                  SizedBox(height: 19.h),
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
                    onChanged: authCubit.validEmail,
                    controller: authCubit.emailRegCtrl,
                    borderRadius: 5,
                    keyboardType: TextInputType.emailAddress,
                    borderColor: authCubit.isEmail ? null : appColors.red,
                  ),
                  state is IsNotEmail
                      ? AuthText(
                          text: 'Invalid Email',
                          color: appColors.red,
                          size: 12,
                          fontWeight: FontWeight.w400,
                        )
                      : Container(),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                      text: 'Password',
                      color: appColors.secondText,
                      size: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      authCubit.passwordValid(password: value);
                    },
                    controller: authCubit.passwordRegCtrl,
                    obscureText: true,
                    toggleObscure: true,
                    borderRadius: 5,
                    borderColor: authCubit.isPassWord ? null : Colors.red,
                  ),
                  state is FalsePasswordFormat
                      ? SizedBox(
                          height: 20.h,
                          child: AuthText(
                            text: 'At least 8 char,lower,upper,symbols',
                            color: Colors.red,
                            size: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 19.h),
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
                      authCubit.passwordConfValid(password: value);
                    },
                    controller: authCubit.confirmPasswordCtrl,
                    obscureText: true,
                    toggleObscure: true,
                    borderColor: authCubit.isPassWordconf ? null : Colors.red,
                  ),
                  state is FalsePasswordConfirmationFormat
                      ? SizedBox(
                          height: 20.h,
                          child: AuthText(
                            text: 'At least 8 char,lower,upper,symbols',
                            color: Colors.red,
                            size: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                      text: 'Bio',
                      color: appColors.secondText,
                      size: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    controller: authCubit.bioCtrl,
                    borderRadius: 5,
                  ),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                      text: 'Github Account',
                      color: appColors.secondText,
                      size: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    controller: authCubit.githubAccount,
                    borderRadius: 5,
                  ),
                  SizedBox(height: 37.h),
                  SizedBox(
                      height: 50.h,
                      child: state is SignUpLoading
                          ? Center(
                              child: Loading(
                                height: 50,
                                width: 50,
                              ),
                            )
                          : OnBordingContainer(
                              width: 300,
                              height: 50,
                              color: appColors.primary,
                              widget: AuthText(
                                text: 'Register',
                                color: appColors.mainText,
                                size: 22,
                                fontWeight: FontWeight.w700,
                              ),
                              onTap: () {
                                authCubit.signUp();
                              },
                            )),
                  SizedBox(height: 35.h),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Align(
                        alignment: Alignment.center,
                        child: AuthText(
                          text: 'OR Login',
                          color: appColors.primary,
                          size: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
