import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/learn_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewlearn extends StatelessWidget {
  final List<LearnPathInfoCourse> list;
  const Gridviewlearn({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      padding: EdgeInsets.zero,
      height: 230.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400.w,
          childAspectRatio: 335.w/117.h,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
        ),
        itemBuilder: (ctx, index) {
          final coursesList=list[index];
          return LearnCard(
            learnPathInfoCourse: coursesList,
          );
        },
      ),
    );
  }
}
