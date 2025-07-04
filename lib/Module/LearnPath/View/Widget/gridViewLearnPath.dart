import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/LearnPath/Cubit/learn_path_cubit.dart';
import 'package:lms/Module/LearnPath/Model/learn_path_reaponse.dart';
import 'package:lms/Module/LearnPath/View/Widget/LearnPathCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewlearnpath extends StatelessWidget {
  Gridviewlearnpath({super.key, required this.cubit});
  LearnPathCubit cubit;
   @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      height: 520,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount:cubit.learningPathsResponse!.data.learningPaths.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          return Learnpathcard(
            learnPath: cubit.learningPathsResponse!.data.learningPaths[index],
          );
        },
      ),
    );
  }
}
