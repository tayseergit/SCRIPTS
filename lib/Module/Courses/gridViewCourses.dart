import 'package:flutter/material.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Courses/coursesCard.dart';

class Gridviewcourses extends StatelessWidget {
  const Gridviewcourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      color: AppColors.white,
      child: GridView.builder(
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 165,
          childAspectRatio: 0.825,
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
