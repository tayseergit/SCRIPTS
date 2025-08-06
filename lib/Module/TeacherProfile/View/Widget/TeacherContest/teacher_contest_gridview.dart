import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/TeacherProfile/Model/teacher_contest_model.dart';
import 'package:lms/Module/TeacherProfile/View/Widget/TeacherContest/teacher_contest_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';

class TeacherContestGridview extends StatelessWidget {
  final List<TeacherContestData> teacherContest;
  const TeacherContestGridview({super.key, required this.teacherContest});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;


if (teacherContest.isEmpty) {
      return Center(
        heightFactor: 1.5,
        child: SizedBox(
          height: 200.h,
          child: NoItem(),
        ),
      );
    }


    return Container(
      height: 500.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: teacherContest.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400.w,
          childAspectRatio: 2.w/1.4.h,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
        ),
        itemBuilder: (ctx, index) {
          final contest=teacherContest[index];
          return TeacherContestCard(
            teacherContestData: contest,
          );
        },
      ),
    );
  }
}
