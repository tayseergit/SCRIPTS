import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Contest/ContestCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewcontest extends StatelessWidget {
  const Gridviewcontest({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Container(
      height: 500,
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
          return Contestcard();
        },
      ),
    );
  }
}
