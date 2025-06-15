import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Teacher/TescherCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewteacher extends StatelessWidget {
  const Gridviewteacher({super.key});

  @override
  Widget build(BuildContext context) {
      ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 610,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 17.h),
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.95,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15
        ),
        itemBuilder: (ctx, index) {
          return Teschercard();
        },
      ),
    );
  }
}
