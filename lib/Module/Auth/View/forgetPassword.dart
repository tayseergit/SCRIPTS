import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Auth/View/resetPassword.dart';
import 'package:lms/Module/Auth/cubit/forget_password_cubit.dart';
import 'package:lms/Module/Verify/Cubite/cubit/verfiy_cubit.dart';
import 'package:lms/Module/Verify/View/verify.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is SendCodeSuccess) {
            final cubit = context.read<ForgetPasswordCubit>();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: VerifyCubit(),
                  child: Verify(
                    email: cubit.emailctrl.text.trim(),
                    registretion: 0,
                  ),
                ),
              ),
            );
          } else if (state is SendCodeError) {
            customSnackBar(
                context: context, success: 0, message: state.message);
          } else if (state is ForgetPasswordErrorConnection) {
            customSnackBar(
                context: context, success: 0, message: state.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgetPasswordCubit>();
          return Scaffold(
            backgroundColor: appColors.pageBackground,
            body: ListView(
              padding: EdgeInsets.only(top: 85, left: 19, right: 19),
              children: [
                Image.asset(Images.logo, height: 153.h, width: 114.w),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.center,
                  child: AuthText(
                    text: lang.forget_password,
                    size: 18,
                    color: appColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 77.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AuthText(
                    text: lang.email,
                    color: appColors.secondText,
                    size: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  onChanged: cubit.validEmail,
                  controller: cubit.emailctrl,
                  borderRadius: 5,
                  keyboardType: TextInputType.emailAddress,
                  borderColor: cubit.isEmail ? null : appColors.red,
                ),
                !cubit.isEmail
                    ? AuthText(
                        text: lang.invalid_email,
                        color: appColors.red,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      )
                    : Container(),
                SizedBox(height: 69.h),
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
                            text: lang.Send_code,
                            size: 18,
                            color: appColors.mainText,
                            fontWeight: FontWeight.w700,
                          ),
                          onTap: () {
                            cubit.sendCode(context);
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
