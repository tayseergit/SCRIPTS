import 'package:flutter/material.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/LearnPath/LearnPathCard.dart';

class Gridviewlearnpath extends StatelessWidget {
  const Gridviewlearnpath({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
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
          return Learnpathcard();
        },
      ),
    );
  }
}
