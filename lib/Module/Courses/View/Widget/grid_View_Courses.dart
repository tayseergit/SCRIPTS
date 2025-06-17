import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Courses/View/Widget/courses_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewcourses extends StatelessWidget {
  const Gridviewcourses({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 510.h, // Responsive height
      color: appColors.pageBackground,
      child: GridView.builder(
        // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180.w, // Responsive max width per card
          childAspectRatio: 180.w / 250.h, // Match the card's actual aspect
          mainAxisSpacing: 12.h, // Responsive vertical spacing
          crossAxisSpacing: 12.w, // Responsive horizontal spacing
        ),
        itemBuilder: (ctx, index) {
          return const Cursescard();
        },
      ),
    );
  }
}
