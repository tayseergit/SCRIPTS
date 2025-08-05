import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Participants/Cubit/Participants_cubit.dart';
import 'package:lms/Module/Participants/View/Widget/Participants_card.dart';
import 'package:lms/Module/Teacher/Model/teacher_model.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';

class ParticipantsGridview extends StatelessWidget {
  final List<TeacherModel> teacher;
  const ParticipantsGridview({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ParticipantsCubit>();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    if (teacher.isEmpty) {
      return Center(
        heightFactor: 1.5,
        child: SizedBox(
          height: 200.h,
          child: NoItem(),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          final metrics = scrollNotification.metrics;
          if (metrics.atEdge && metrics.pixels != 0) {
            if (cubit.hasMore && !cubit.isLoadingMore) {
              cubit.fetchAllParticipants(loadMore: true);
            }
          }
        }
        return false;
      },
      child: Container(
        height: 610,
        color: appColors.pageBackground,
        child: GridView.builder(
          padding: EdgeInsets.only(top: 17.h),
          itemCount: teacher.length + (cubit.hasMore ? 1 : 0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.95,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (ctx, index) {
            if (index >= teacher.length) {
              return Center(child: CircularProgressIndicator());
            }
            final teacherList = teacher[index];
            return ParticipantsCard(
              teacherModel: teacherList,
            );
          },
        ),
      ),
    );
  }
}
