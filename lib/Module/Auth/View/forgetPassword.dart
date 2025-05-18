import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/View/resetPassword.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Auth/Widget/CustomTextField.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/app_color_cubit.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();

    return Scaffold(
      backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
      body: ListView(
        padding: EdgeInsets.only(top: 85, left: 19, right: 19),
        children: [
          Image.asset('assets/images/image.png', height: 153.h, width: 114.w),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Forget Password ',
              size: 18,
              coloer: Appcolors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 77.h),

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
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5,
            borderColor: Appcolors.textfilde,
            fillColor: context.watch<ThemeCubit>().state.textFieldColor,
            textColor: context.watch<ThemeCubit>().state.textColor,
          ),

          SizedBox(height: 69.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 45.w),
            child: OnBordingContainer(
              width: 223,
              height: 50,
              color: Appcolors.primary,
              widget: AuthText(
                text: 'Send a code',
                size: 20,
                coloer: Appcolors.textprem,
                fontWeight: FontWeight.w700,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Resetpassword()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
