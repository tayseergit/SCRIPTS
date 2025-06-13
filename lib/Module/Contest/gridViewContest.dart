import 'package:flutter/material.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Contest/ContestCard.dart';

class Gridviewcontest extends StatelessWidget {
  const Gridviewcontest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: AppColors.white,
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
