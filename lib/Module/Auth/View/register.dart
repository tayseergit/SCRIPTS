import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/View/verify.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Auth/Widget/CustomTextField.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/app_color_cubit.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController confirmPassword = TextEditingController();
    final TextEditingController bio = TextEditingController();
    final TextEditingController githubAccont = TextEditingController();
    return Scaffold(
      backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
        elevation: 0,
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
                text: 'Register',
                coloer: Appcolors.primary,
                size: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 31.h, left: 19.w, right: 19.w),
        children: [
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
                      Appcolors.primary,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 45.r,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: null,
                child: Icon(Icons.person, size: 40.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 110),
            child: OnBordingContainer(
              width: 100,
              height: 30,
              color: Appcolors.primary,
              widget: AuthText(
                text: 'Add image',
                coloer: context.watch<ThemeCubit>().state.textColor,
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
          SizedBox(height: 15.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Name',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: name,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),
          SizedBox(height: 19.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Email',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: email,
            borderRadius: 5,
            keyboardType: TextInputType.emailAddress,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),

          SizedBox(height: 19.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Password',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
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

          SizedBox(height: 19.h),
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
            controller: confirmPassword,
            obscureText: true,
            toggleObscure: true,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),

          SizedBox(height: 19.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Bio',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: bio,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),
          SizedBox(height: 19.h),
          Align(
            alignment: Alignment.centerLeft,
            child: AuthText(
              text: 'Github Accont',
              coloer: context.watch<ThemeCubit>().state.textColor,
              size: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomTextField(
            controller: githubAccont,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),
          SizedBox(height: 37.h),
          OnBordingContainer(
            width: 370,
            height: 50,
            color: Appcolors.primary,
            widget: AuthText(
              text: 'Register',
              coloer: context.watch<ThemeCubit>().state.backgroundColor,
              size: 22,
              fontWeight: FontWeight.w700,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Verify()),
              );
            },
          ),
          SizedBox(height: 35.h),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Align(
                alignment: Alignment.center,
                child: AuthText(
                  text: 'OR Login',
                  coloer: Appcolors.primary,
                  size: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
