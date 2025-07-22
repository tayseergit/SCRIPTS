import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Vedio/CoursesVedioCard.dart';

class GridviewVediocourses extends StatelessWidget {
  const GridviewVediocourses({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      height: 500,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: 19,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 5.3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return Coursesvediocard();
        },
      ),
    );
  }
}
