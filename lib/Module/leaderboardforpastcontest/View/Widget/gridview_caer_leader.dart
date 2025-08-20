import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/Cubit/card_expand_cubit.dart';
import 'package:lms/Module/leaderboardforpastcontest/Model/leader_board_for_past_contest_model.dart';
import 'package:lms/Module/leaderboardforpastcontest/View/Widget/card.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';

class GridviewCaerLeader extends StatelessWidget {
  final List<Studentss> students;
  final int questionCount;
  const GridviewCaerLeader(
      {super.key, required this.students, required this.questionCount});

  @override
  Widget build(BuildContext context) {
    print('🟢 [Q] بناء GridviewCaerLeader');
    print('🟢 [R] عدد الطلاب: ${students.length}');
    ThemeState appColors = context.watch<ThemeCubit>().state;

   
    if (students.isEmpty) {
      return Center(
        heightFactor: 1.5,
        child: SizedBox(
          height: 200.h,
          child: NoItem(),
        ),
      );
    }
    print('🟢 [T] بدء بناء GridView');
    return BlocProvider(
      create: (context) => CardExpandCubit(),
      child: BlocBuilder<CardExpandCubit, Map<int, bool>>(
        builder: (context, state) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 17.h),
            itemCount:
                students.length > 3 ? students.length - 3 : students.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              final adjustedIndex = index + 3;
              if (students.length > 3)
                return CardLeader(
                  index: adjustedIndex + 1,
                  student: students[adjustedIndex],
                  questionCount: questionCount,
                );
              if (students.length < 3)
                return CardLeader(
                  index: index + 1,
                  student: students[index],
                  questionCount: questionCount,
                );
            },
          );
        },
      ),
    );
  }
}
