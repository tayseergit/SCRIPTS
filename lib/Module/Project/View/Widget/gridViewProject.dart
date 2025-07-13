import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Project/View/Widget/ProjectCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewproject extends StatelessWidget {
  const Gridviewproject({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 615,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 17.h),
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 170/255,
          mainAxisSpacing: 15,
          crossAxisSpacing: 1
        ),
        itemBuilder: (ctx, index) {
          return Projectcard();
        },
      ),
    );
  }
}
