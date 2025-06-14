import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/profileCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewprofile extends StatelessWidget {
  const Gridviewprofile({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 540,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 17.h),
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.95,
          mainAxisSpacing: 15,
          crossAxisSpacing: 1
        ),
        itemBuilder: (ctx, index) {
          return Profilecard();
        },
      ),
    );
  }
}
