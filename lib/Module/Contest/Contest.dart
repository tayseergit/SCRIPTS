// lib/Module/Courses/page/courses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Module/Contest/TabButtonsForContest.dart';
import 'package:lms/Module/Contest/TabbuttonsforcontestCubit.dart';
import 'package:lms/Module/Contest/gridViewContest.dart';
import 'package:lms/Utils/customTextFieldSearsh.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';


class Contest extends StatelessWidget {
  const Contest({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (_) => TabbuttonsforcontestCubit(),
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: appColors.pageBackground,
          elevation: 0,
          title: Align(
            alignment: Alignment.center,
            child: AuthText(
              text: 'Contest',
              size: 24,
              color: appColors.mainText,
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
              borderColor: appColors.primary,
              prefixIcon: Icon(
                Icons.search_outlined,
                size: 30,
                color: appColors.seocndIconColor,
              ),
              suffixIcon: Image.asset(
                Images.filter,
                width: 17.w,
                height: 17.h,
                color: appColors.iconSearsh,
              ),
              hintText: 'what do you want to learn ?',
              hintColor: appColors.gray,
              hintFontSize: 13.sp,
              hintFontWeight: FontWeight.w600,
              fillColor: appColors.white
            ),
            SizedBox(height: 15.h),
            const Tabbuttonsforcontest(),
            SizedBox(height: 10.h),
            BlocBuilder<TabbuttonsforcontestCubit, int>(
              builder: (context, state) {
                switch (state) {
                  case 0:
                    return Gridviewcontest();
                  case 1:
                    return _buildSimpleTab(context, 'Enroll Content');
                  case 2:
                    return _buildSimpleTab(context, 'Completed Content');
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
        style: TextStyle(color: appColors.black),
      ),
    );
  }
}
