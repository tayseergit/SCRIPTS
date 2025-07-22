import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/LearnPathInfo/LearnCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewlearn extends StatelessWidget {
  const Gridviewlearn({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      padding: EdgeInsets.zero,
      height: 230.h,
      color: appColors.pageBackground,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 19,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 335/117,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return LearnCard();
        },
      ),
    );
  }
}
