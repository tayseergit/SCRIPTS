import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/MyLearn/SectionCubit.dart';

class MainTabButton extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;

  const MainTabButton({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: InkWell(
          onTap: () => context.read<SectionCubit>().changeSection(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthText(
                text: title,
                size: 18,
                color: isSelected ? AppColors.primary : AppColors.gray,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10.h),
              Divider(
                color: isSelected ? AppColors.primary : AppColors.gray,
                thickness: 2,
                indent: 25,
                endIndent: 25,
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
