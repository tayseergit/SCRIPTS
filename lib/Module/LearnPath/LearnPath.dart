// lib/Module/Courses/page/courses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Courses/TabButtons.dart';
import 'package:lms/Module/Courses/TapBarCubit.dart';
import 'package:lms/Module/Courses/customTextFieldSearsh.dart';
import 'package:lms/Module/LearnPath/gridViewLearnPath.dart';


class Learnpath extends StatelessWidget {
  const Learnpath({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();

    return BlocProvider(
      create: (_) => TabCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor:AppColors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Learn Path',
              size: 24,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          children: [
            Customtextfieldsearsh(
              borderRadius: 6,
              controller: search,
              borderColor: AppColors.primary,
              prefixIcon: Icon(
                Icons.search_outlined,
                size: 30,
                color: AppColors.iconSearsh,
              ),
              suffixIcon: Image.asset(
                Images.filter,
                width: 17.w,
                height: 17.h,
                color: AppColors.iconSearsh,
              ),
              hintText: 'what do you want to learn ?',
              hintColor: AppColors.iconSearsh,
              hintFontSize: 13.sp,
              hintFontWeight: FontWeight.w600,
              fillColor: AppColors.white
            ),
            SizedBox(height: 15.h),
            const TabButtons(),
            SizedBox(height: 10.h),
            BlocBuilder<TabCubit, int>(
              builder: (context, state) {
                switch (state) {
                  case 0:
                    return Gridviewlearnpath();
                  case 1:
                    return _buildSimpleTab(context, 'Enroll Content');
                  case 2:
                    return _buildSimpleTab(context, 'Completed Content');
                  case 3:
                    return _buildSimpleTab(context, 'Watchlater Content');
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleTab(BuildContext context, String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: AppColors.white),
      ),
    );
  }
}


