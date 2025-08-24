import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/View/Widget/learn_Info_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class GridviewlearnInfo extends StatelessWidget {
  final List<LearnPathInfoCourse> list;
  const GridviewlearnInfo({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      // height: 140.h * list.length,
      padding: EdgeInsets.zero,
      color: appColors.pageBackground,
      child: ListView.separated(
        shrinkWrap: true, // let it size itself based on content
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          final coursesList = list[index];
          return LearnInfoCard(
            learnPathInfoCourse: coursesList,
          );
        },
        separatorBuilder: (ctx, index) =>
            SizedBox(height: 10.h), // المسافة بين العناصر
      ),
    );
  }
}
