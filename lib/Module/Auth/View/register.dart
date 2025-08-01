import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/image_picker.dart';
import 'package:lms/Module/Localization/localization.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Verify/View/verify.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/auth_state.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/shake_animation.dart';
import 'package:lms/generated/l10n.dart';

class Register extends StatelessWidget {
  Register({super.key});
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      color: appColors.primary,
      child: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            AuthCubit authCubit = context.read<AuthCubit>();
            if (state is SignUpSuccess) {
              CustomSnackbar.show(
                fillColor: appColors.ok,
                context: context,
                message: lang.code_sent,
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                pushTo(
                    context: context,
                    toPage: Verify(
                      email: authCubit.emailRegCtrl.text,
                      registretion: 1,
                    ));
              });
            } else if (state is SignUpError) {
              customSnackBar(
                  context: context, success: 0, message: state.message);
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
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
                        InkWell(
                          onTap: context.read<LocaleCubit>().toggleLocale,
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
                          text: lang.register,
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
                        backgroundImage: authCubit.pickedImage != null
                            ? FileImage(File(authCubit.pickedImage!.path))
                            : null,
                        child: authCubit.pickedImage == null
                            ? Icon(Icons.person,
                                size: 40.sp, color: Colors.grey)
                            : null,
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 110),
                    child: OnBoardingContainer(
                        width: 100,
                        height: 40,
                        color: appColors.primary,
                        widget: AuthText(
                          text: lang.add_image,
                          color: appColors.mainText,
                          size: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        onTap: () async {
                          final xfile = await ImageService()
                              .pickImageFromGallery(context);
                          if (xfile != null) {
                            final file =
                                File(xfile.path); // ✅ correct conversion
                            selectedImage = file;
                            authCubit.setPickedImage(file);
                            print('Picked: ${file.path}');
                          }
                        }),
                  ),
                  SizedBox(height: 36.h),
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
                                authCubit.loginWithGoogle();
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
                  SizedBox(height: 15.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthText(
                      text: lang.name,
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
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthText(
                      text: lang.email,
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
                          text: lang.invalid_email,
                          color: appColors.red,
                          size: 12,
                          fontWeight: FontWeight.w400,
                        )
                      : Container(),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthText(
                      text: lang.password,
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
                            text: lang.at_least_8_char_lower_upper_symbols,
                            color: Colors.red,
                            size: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthText(
                      text: lang.confirm_password,
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
                            text: lang.at_least_8_char_lower_upper_symbols,
                            color: Colors.red,
                            size: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthText(
                      text: lang.bio,
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
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthText(
                      text: lang.github_account,
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
                          : OnBoardingContainer(
                              width: 300,
                              height: 50,
                              color: appColors.primary,
                              widget: AuthText(
                                text: lang.register,
                                color: appColors.mainText,
                                size: 22,
                                fontWeight: FontWeight.w700,
                              ),
                              onTap: () {
                                authCubit.signUp(context);
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
                          text: lang.or_login,
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
