import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Courses/coursesCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewcourses extends StatelessWidget {
  const Gridviewcourses({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 510,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 165,
          childAspectRatio: 0.750,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          return Cursescard();
        },
      ),
    );
  }
}
