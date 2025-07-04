import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
 import 'package:lms/Module/Teacher/gridViewTeacher.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';


class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(
            height: 140.h,
          ),
         
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 150),
              child: Customtextfieldsearsh(onSubmit: 
              () {
                
              },
                borderRadius: 6,
                controller: search,
                borderColor: appColors.primary,
                prefixIcon: Icon(
                  Icons.search_outlined,
                  size: 30,
                  color: appColors.iconSearsh,
                ),
                suffixIcon: Image.asset(
                  Images.filter,
                  width: 17.w,
                  height: 17.h,
                  color: appColors.iconSearsh,
                ),
                hintText: 'which teacher?',
                hintFontSize: 13.sp,
                hintFontWeight: FontWeight.w600,
                fillColor: appColors.pageBackground,
              ),
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          Gridviewteacher(),
        ],
      ),
    );
  }
}
