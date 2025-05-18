import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Auth/cubit/app_color_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    return Scaffold(
      backgroundColor: context.watch<ThemeCubit>().state.backgroundColor,
      body: ListView(
        padding: EdgeInsets.only(top: 104),
        children: [
          Image.asset(
            'assets/images/image copy.png',
            height: 97.h,
            width: 218.w,
          ),
          SizedBox(height: 49.h),
          Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Verify Code',
              size: 20,
              coloer: context.watch<ThemeCubit>().state.textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 56.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: PinCodeTextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor:
                    context.watch<ThemeCubit>().state.backgroundColor,
                selectedColor: Appcolors.primary,
                selectedFillColor:
                    context.watch<ThemeCubit>().state.backgroundColor,
                inactiveColor: Appcolors.primary,
                inactiveFillColor:
                    context.watch<ThemeCubit>().state.backgroundColor,
                activeColor: Appcolors.primary,
              ),
              backgroundColor:
                  context.watch<ThemeCubit>().state.backgroundColor,
              textStyle: TextStyle(
                color: context.watch<ThemeCubit>().state.textColor,
              ),
              enableActiveFill: true,
            ),
          ),
          SizedBox(height: 45.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: OnBordingContainer(
              width: 223,
              height: 50,
              color: Appcolors.primary,
              widget: AuthText(
                text: 'Send',
                size: 20,
                coloer: Appcolors.textprem,
                fontWeight: FontWeight.w700,
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
                size: 24,
                coloer: Appcolors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
