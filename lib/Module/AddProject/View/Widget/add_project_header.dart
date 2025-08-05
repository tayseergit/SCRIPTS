import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/generated/l10n.dart';

class AddProjectHeader extends StatelessWidget {
  const AddProjectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    Color darkText = appColors.mainText;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: appColors.lihgtPrimer,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50.r),
              bottomLeft: Radius.circular(50.r))),
      padding:
          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            lang.add_new_project,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            lang.fill_details,
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
