import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';
import 'package:lms/Module/TeacherProfile/View/Pages/teacher_profile_page.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Teschercard extends StatelessWidget {
  final TeacherModel teacherModel;
  const Teschercard({super.key, required this.teacherModel});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Center(
        child: InkWell(
          onTap: () {
            pushTo(context: context, toPage: TeacherProfilePage(teacherid:teacherModel.id ,));
          },
          child: Container(
            width: 180.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(color: appColors.primary, width: 0.8),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  children: [
                    teacherModel.image != null
                        ? Image.network(
                            teacherModel.image!, // رابط افتراضي إذا كان null
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Images.noProfile, // صورة افتراضية محلية
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            Images.noProfile,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              appColors.mainIconColor.withOpacity(0),
                              appColors.primary.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                              color: appColors.mainText.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: appColors.primary)),
                          child: Text(
                            teacherModel.name,
                            style: TextStyle(
                              color: appColors.pageBackground,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
