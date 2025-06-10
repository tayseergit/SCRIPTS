import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/LearnPath/LearnPathCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewlearnpath extends StatelessWidget {
  const Gridviewlearnpath({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      height: 520,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          return Learnpathcard();
        },
      ),
    );
  }
}
