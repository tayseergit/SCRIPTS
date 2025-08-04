import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
 import 'package:lms/Module/Them/cubit/app_color_state.dart';

class FileUploadCard extends StatelessWidget {
  const FileUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    Color darkText = appColors.mainText;
    Color accentColor = appColors.primary;
    Color primaryColor = appColors.primary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color:appColors. whiteText,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: accentColor, width: 2.w),
      ),
      child: Column(
        children: [
          
          SizedBox(height: 10.h),
          Text(
            'Choose File to upload',
            style: TextStyle(
              fontSize: 16.sp,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}