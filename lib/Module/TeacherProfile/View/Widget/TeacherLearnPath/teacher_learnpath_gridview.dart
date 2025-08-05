import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_learnpath_model.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherLearnPath/teacher_learnpath_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';

class TeacherLearnpathGridview extends StatelessWidget {
  final List<TeacherLearnpathModel> LearnPathlist;
  TeacherLearnpathGridview({super.key, required this.LearnPathlist});
  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    if (LearnPathlist.isEmpty) {
      return Center(
        heightFactor: 1.5,
        child: SizedBox(
          height: 200.h,
          child: NoItem(),
        ),
      );
    }
    return Container(
      height: 505.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: LearnPathlist.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400.h,
          childAspectRatio: 1,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
        ),
        itemBuilder: (ctx, index) {
          final learnPath = LearnPathlist[index];
          return TeacherLearnpathCard(
            teacherLearnpathModel: learnPath,
          );
        },
      ),
    );
  }
}
