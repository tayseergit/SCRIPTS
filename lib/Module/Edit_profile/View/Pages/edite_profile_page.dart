import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/Edit_profile/Cubit/edite_profile_cubit.dart';
import 'package:lms/Module/Edit_profile/Cubit/edite_profile_state.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/CustomTextField.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/generated/l10n.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  final TextEditingController githubCtrl = TextEditingController();

  File? selectedImage;

  void pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => selectedImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final appColors = context.read<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => EditeProfileCubit(),
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: SafeArea(
          child: BlocConsumer<EditeProfileCubit, EditeProfileState>(
            listener: (context, state) {
              if (state is EditeProfileSuccess) {
                print("✅ Profile updated successfully");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(lang.profile_updated)),
                );
                Navigator.pop(context);
                context.read<StudentProfileCubit>().getProfile(CacheHelper.getUserId());
              } else if (state is EditeProfileError) {
                print("❌ Error: ${state.message}");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is EditeProfileLoading;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                children: [
                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: appColors.mainText),
                      ),
                      AuthText(
                        text: lang.edit_profile,
                        color: appColors.primary,
                        size: 28,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(width: 25),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  /// صورة البروفايل
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
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                        child: selectedImage == null
                            ? Icon(Icons.person,
                                size: 40.sp, color: Colors.grey)
                            : null,
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),

                  /// زر اختيار صورة
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
                      onTap: pickImage,
                    ),
                  ),
                  SizedBox(height: 36.h),

                  /// الاسم
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
                    controller: nameCtrl,
                    borderRadius: 5,
                    borderColor: appColors.border,
                    fillColor: appColors.fieldBackground,
                    textColor: appColors.mainText,
                  ),
                  SizedBox(height: 19.h),

                  /// النبذة
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
                    controller: bioCtrl,
                    borderRadius: 5,
                  ),
                  SizedBox(height: 19.h),

                  /// GitHub
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
                    controller: githubCtrl,
                    borderRadius: 5,
                  ),
                  SizedBox(height: 37.h),

                  /// زر التحديث
                  SizedBox(
                    height: 50.h,
                    child: isLoading
                        ? Center(child: Loading(height: 50, width: 50))
                        : OnBoardingContainer(
                            width: 300,
                            height: 50,
                            color: appColors.primary,
                            widget: AuthText(
                              text: lang.profile_updated,
                              color: appColors.mainText,
                              size: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            onTap: () {
                              final githubText = githubCtrl.text.trim();

                              if (nameCtrl.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("⚠️ الرجاء إدخال اسم")),
                                );
                                return;
                              }

                              if (githubText.isNotEmpty) {
                                final urlPattern = RegExp(
                                    r'^https:\/\/github\.com\/[A-Za-z0-9_-]+$');
                                if (!urlPattern.hasMatch(githubText)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "⚠️ الرجاء إدخال رابط GitHub صحيح، مثل: https://github.com/YourUserName")),
                                  );
                                  return;
                                }
                              }

                              context.read<EditeProfileCubit>().updateProfile(
                                    name: nameCtrl.text,
                                    bio: bioCtrl.text,
                                    gitHubAccount: githubText,
                                    age: "25",
                                    image: selectedImage,
                                    context: context,
                                  );
                            },
                          ),
                  ),
                  SizedBox(height: 35.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
