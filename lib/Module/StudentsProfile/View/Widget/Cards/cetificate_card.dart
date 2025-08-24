import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/Model/CertificatesModel.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Certificate/generate_cetificate_image.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class CertificateCard extends StatelessWidget {
  final Certificate certificate;

  const CertificateCard({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    final ThemeState appColors = context.watch<ThemeCubit>().state;

    return InkWell(
      onTap: () {
        showCertificateDialog(
            context,
            certificate.title,
            certificate.obtainDate,
            context.read<StudentProfileCubit>().studentProfileModel.name);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: appColors.primary),
          gradient: appColors.linerContainer.withOpacity(0.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Images.certificate,
                width: double.infinity,
                height: 140.h,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthText(
                      text: certificate.title,
                      size: 14.sp,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.h),
                    AuthText(
                      text: certificate.obtainDate,
                      size: 12.sp,
                      color: appColors.secondText,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
