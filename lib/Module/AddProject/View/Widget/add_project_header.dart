import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
 
class AddProjectHeader extends StatelessWidget {
  const AddProjectHeader({super.key});

  @override
  Widget build(BuildContext context) {
        ThemeState appColors = context.watch<ThemeCubit>().state;

      Color darkText = appColors.mainText;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add A New Project',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Please fill in all the details of your project.',
            style: TextStyle(
              fontSize: 14.sp,
              color: darkText.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}