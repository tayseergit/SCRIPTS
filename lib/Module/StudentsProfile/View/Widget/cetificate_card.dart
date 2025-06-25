import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/Model/CertificatesModel.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/authText.dart';

class CetifiateCard extends StatelessWidget {
  CetifiateCard({super.key, required this.certificate});
  Certificate certificate;
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              border: Border.all(color: appColors.primary)),
          child: OnBoardingContainer(
            width: double.infinity,
            height: double.infinity,
            color: appColors.fieldBackground,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: AuthText(
                          text: certificate.title,
                          size: 12,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthText(
                        text: certificate.obtainDate,
                        size: 12,
                        color: appColors.secondText,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Image.asset(
                    Images.noImage,
                    width: 170.w,
                    height: 110.h,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
