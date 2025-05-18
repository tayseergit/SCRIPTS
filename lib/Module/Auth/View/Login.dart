import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/View/forgetPassword.dart';
import 'package:lms/Module/Auth/View/register.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Auth/Widget/CustomTextField.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/app_color_cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Scaffold(
      backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
        title: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  AuthText(
                    text: 'English',
                    coloer: context.watch<ThemeCubit>().state.textColor,
                    size: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    child: Image.asset(
                      'assets/icons/image.png',
                      height: 30.h,
                      width: 30.w,
                      color: context.watch<ThemeCubit>().state.textColor,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AuthText(
                text: 'Login',
                coloer: Appcolors.primary,
                size: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        children: [
          SizedBox(height: 36.h),
          Image.asset('assets/images/image.png', height: 110.h, width: 150.w),
          SizedBox(height: 92),
          AuthText(
            text: 'Email',
            coloer: context.watch<ThemeCubit>().state.textColor,
            size: 12,
            fontWeight: FontWeight.w400,
          ),
          CustomTextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),
          SizedBox(height: 19),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AuthText(
                text: 'Password',
                coloer: context.watch<ThemeCubit>().state.textColor,
                size: 13,
                fontWeight: FontWeight.w400,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Forgetpassword()),
                  );
                },
                child: AuthText(
                  text: 'Forget Password?',
                  coloer: Appcolors.primary,
                  size: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          CustomTextField(
            controller: password,
            obscureText: true,
            toggleObscure: true,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),

          SizedBox(height: 37.h),
          OnBordingContainer(
            width: double.infinity,
            height: 45,
            color: Appcolors.primary,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/image copy 2.png',
                  height: 20.h,
                  width: 20.w,
                  color: context.watch<ThemeCubit>().state.backgroundColor,
                ),
                SizedBox(width: 15.w),
                AuthText(
                  text: 'Login',
                  coloer: context.watch<ThemeCubit>().state.backgroundColor,
                  size: 22,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            onTap: () {},
          ),
          SizedBox(height: 33.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Appcolors.textfilde, width: 1.5.w),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: OnBordingContainer(
                  width: 170,
                  height: 45,
                  color: context.watch<ThemeCubit>().state.textFieldColor,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/image copy 3.png',
                        height: 20.h,
                        width: 20.w,
                        color: context.watch<ThemeCubit>().state.textColor,
                      ),
                      SizedBox(width: 15.w),
                      AuthText(
                        text: 'Google',
                        coloer: context.watch<ThemeCubit>().state.textColor,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Appcolors.textfilde, width: 1.5.w),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: OnBordingContainer(
                  width: 170.w,
                  height: 45.h,
                  color: context.watch<ThemeCubit>().state.textFieldColor,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/image copy 4.png',
                        height: 20.h,
                        width: 20.w,
                        color: context.watch<ThemeCubit>().state.textColor,
                      ),
                      SizedBox(width: 15.w),
                      AuthText(
                        text: 'GitHub',
                        coloer: context.watch<ThemeCubit>().state.textColor,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 33.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthText(
                text: 'Dont have account ? ',
                coloer: context.watch<ThemeCubit>().state.textColor,
                size: 16,
                fontWeight: FontWeight.w400,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: AuthText(
                  text: 'Register ',
                  coloer: Appcolors.primary,
                  size: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
