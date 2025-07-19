import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Project/Model/projet_response.dart';
import 'package:lms/Module/Project/View/Widget/ProjectCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading_container.dart';

class GridviewLoading extends StatelessWidget {
  GridviewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 615.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 17.h),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220.h,
            childAspectRatio: 175 / 255,
            mainAxisSpacing: 15.w,
            crossAxisSpacing: 10.w),
        itemBuilder: (ctx, index) {
          return LoadingContainer(
            height: 250.h,
          );
        },
      ),
    );
  }
}
