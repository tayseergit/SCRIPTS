import 'package:flutter/material.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/MyLearn/myLearnCard.dart';

class Gridviewmylearn extends StatelessWidget {
  const Gridviewmylearn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 670,
      color: AppColors.white,
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 349/130,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          return Mylearncard();
        },
      ),
    );
  }
}
