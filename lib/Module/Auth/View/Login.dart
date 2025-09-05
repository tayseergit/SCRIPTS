import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/forgetPassword_page.dart';
import 'package:lms/Module/Auth/View/register_page.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/LearnPath/View/Pages/learn_path_page.dart';
import 'package:lms/Module/Localization/localization.dart';
import 'package:lms/Module/NavigationBarWidged/navigationBarWidget.dart';
import 'package:lms/Module/NavigationBarWidged/navigation_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';

import 'package:lms/Module/mainWidget/shake_animation.dart';
import 'package:lms/generated/l10n.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final lang = S.of(context);
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      AuthCubit authCubit = context.read<AuthCubit>();

      print(state);
      if (state is LogInsucess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: NavigationCubit(),
              child: NavigationBarwidget(),
            ),
          ),
          (route) => false,
        );
        // Future.delayed(Duration(milliseconds: 700), () {
        //   CustomSnackbar.show(
        //     context: context,
        //     fillColor: appColors.ok,
        //     message: "Login Completed",
        //   );
        // });
      } else if (state is CheckInfo) {
        customSnackBar(
            context: context,
            success: 0,
            message: lang.check_email_or_password);
      } else if (state is LogInErrorConnection) {
        customSnackBar(context: context, success: 0, message: state.message);
      } else if (state is LogInError) {
        customSnackBar(context: context, success: 0, message: state.message);
      }
    }, builder: (context, state) {
      AuthCubit authCubit = AuthCubit.get(context);
      return SafeArea(
        child: Scaffold(
            backgroundColor: appColors.pageBackground,
            body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<LocaleCubit>().toggleLocale();
                          },
                          child: AuthText(
                            text: lang.en,
                            color: appColors.mainText,
                            size: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        AuthText(
                          text: lang.login,
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
                  SizedBox(height: 50.h),
                  Image.asset(Images.baseLogo, height: 150.h, width: 200.w),
                  SizedBox(height: 50.h),
                  AuthText(
                    text: lang.email,
                    color: appColors.secondText,
                    size: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomTextField(
                    onChanged: authCubit.validEmail,
                    controller: authCubit.emailLogctrl,
                    keyboardType: TextInputType.emailAddress,
                    borderRadius: 5,
                    borderColor: authCubit.isEmail
                        ? appColors.pageBackground
                        : appColors.red,
                    fillColor: appColors.fieldBackground,
                    textColor: appColors.mainText,
                  ),
                  SizedBox(height: 10.h),
                  state is IsNotEmail
                      ? AuthText(
                          text: lang.invalid_email,
                          color: appColors.red,
                          size: 12,
                          fontWeight: FontWeight.w400,
                        )
                      : Container(),
                  SizedBox(height: 19.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthText(
                        text: lang.password,
                        color: appColors.secondText,
                        size: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      InkWell(
                        onTap: () {
                          pushTo(context: context, toPage: Forgetpassword());
                        },
                        child: AuthText(
                          text: lang.forget_password,
                          color: appColors.primary,
                          size: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    onChanged: (value) =>
                        authCubit.passwordValid(password: value),
                    controller: authCubit.passWordLogctrl,
                    obscureText: true,
                    toggleObscure: true,
                    borderRadius: 5,
                    borderColor: authCubit.isPassWord
                        ? appColors.pageBackground
                        : Colors.red,
                    fillColor: appColors.fieldBackground,
                    textColor: appColors.mainText,
                  ),
                  SizedBox(height: 10.h),
                  state is FalsePasswordFormat
                      ? AuthText(
                          text: lang.at_least_8_char_lower_upper_symbols,
                          color: Colors.red,
                          size: 12,
                          fontWeight: FontWeight.w400,
                        )
                      : Container(),
                  SizedBox(height: 37.h),
                  SizedBox(
                    height: 50
                        .h, // fix the height of the button container (optional)
                    child: state is LogInLoading
                        ? Center(
                            child: Loading(
                              height: 50,
                              width: 50,
                            ),
                          )
                        : OnBoardingContainer(
                            width: 300,
                            height: 50,
                            color: appColors.primary,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Images.login,
                                  height: 20.h,
                                  width: 20.w,
                                  color: appColors.mainIconColor,
                                ),
                                SizedBox(width: 15.w),
                                AuthText(
                                  text: lang.login,
                                  color: appColors.mainText,
                                  size: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            onTap: () {
                              authCubit.logIn(context);
                            },
                          ),
                  ),
                  SizedBox(height: 33.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5.w,
                              ),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: OnBoardingContainer(
                              onTap: () {
                                authCubit.loginWithGoogle(context);
                              },
                              height: 50.h,
                              color: appColors.fieldBackground,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Images.google,
                                    height: 20.h,
                                    width: 20.w,
                                    color: appColors.mainIconColor,
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
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColors.border,
                                width: 1.5.w,
                              ),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: OnBoardingContainer(
                              onTap: () {
                                authCubit.loginWithGithub();
                              },
                              height: 50.h,
                              color: appColors.fieldBackground,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Images.github,
                                    height: 20.h,
                                    width: 20.w,
                                    color: appColors.mainIconColor,
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
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthText(
                        text: lang.dont_have_account,
                        color: appColors.mainText,
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: AuthText(
                          text: lang.register,
                          color: appColors.primary,
                          size: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: NavigationCubit(),
                                child: NavigationBarwidget(),
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: AuthText(
                          text: lang.complete_as_browser,
                          color: appColors.primary,
                          size: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ])),
      );
    });
  }
}
