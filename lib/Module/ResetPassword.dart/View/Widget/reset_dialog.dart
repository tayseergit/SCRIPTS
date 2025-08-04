import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart'; // adjust import path of your localization

import 'package:lms/Module/ResetPassword.dart/cubit/reset_password_cubit.dart';
import 'package:lms/Module/ResetPassword.dart/cubit/reset_password_state.dart';

void showPasswordResetDialog(BuildContext context) {
  var appColors = context.read<ThemeCubit>().state;
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider(
        create: (_) => PasswordResetCubit(),
        child: AlertDialog(
          backgroundColor: appColors.pageBackground,
          title: Text(
            S.of(context).resetPassword,
            style: TextStyle(fontSize: 18.sp),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 300.w,
              child: BlocConsumer<PasswordResetCubit, PasswordResetState>(
                listener: (context, state) {
                  if (state is PasswordResetSuccess) {
                    customSnackBar(
                        context: context, success: 1, message: state.message);
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<PasswordResetCubit>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).old_password,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      CustomTextField(
                        controller: cubit.oldPasswordCtrl,
                        obscureText: true,
                        toggleObscure: true,
                        borderRadius: 5,
                        borderColor: appColors.border,
                        fillColor: appColors.fieldBackground,
                        textColor: appColors.mainText,
                      ),
                      SizedBox(height: 10.h),

                      Text(
                        S.of(context).newPassword,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      CustomTextField(
                        onChanged: (value) =>
                            cubit.passwordValid(password: value),
                        controller: cubit.newPasswordCtrl,
                        obscureText: true,
                        toggleObscure: true,
                        borderRadius: 5,
                        borderColor: appColors.border,
                        fillColor: appColors.fieldBackground,
                        textColor: appColors.mainText,
                      ),
                      !cubit.isPassword
                          ? AuthText(
                              maxLines: 2,
                              text: S
                                  .of(context)
                                  .at_least_8_char_lower_upper_symbols,
                              color: Colors.red,
                              size: 12,
                              fontWeight: FontWeight.w400,
                            )
                          : Container(),
                      SizedBox(height: 10.h),

                      /// ✅ Confirm Password
                      Text(
                        S.of(context).confirmNewPassword,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      CustomTextField(
                        onChanged: (value) =>
                            cubit.passwordConfValid(password: value),
                        controller: cubit.confirmNewPasswordCtrl,
                        obscureText: true,
                        toggleObscure: true,
                        borderRadius: 5,
                        borderColor: appColors.border,
                        fillColor: appColors.fieldBackground,
                        textColor: appColors.mainText,
                      ),
                      !cubit.isConfirmationPassword
                          ? AuthText(
                              text: S.of(context).passwords_do_not_match,
                              color: Colors.red,
                              size: 12,
                              fontWeight: FontWeight.w400,
                            )
                          : Container(),

                      /// Error or Success Message
                      if (state is PasswordResetError)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            state.message,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).cancel,
                  style: TextStyle(fontSize: 16.sp, color: appColors.mainText)),
            ),
            BlocBuilder<PasswordResetCubit, PasswordResetState>(
              builder: (context, state) {
                final cubit = context.read<PasswordResetCubit>();
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        appColors.blackGreen, // Change to your desired color
                  ),
                  onPressed: state is PasswordResetLoading
                      ? null
                      : () {
                          cubit.resetPassword(context);
                          FocusScope.of(context).unfocus();
                        },
                  child: state is PasswordResetLoading
                      ? Center(child: Loading(height: 50, width: 50))
                      : Text(S.of(context).submit,
                          style: TextStyle(
                              fontSize: 16.sp, color: appColors.whiteText)),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
