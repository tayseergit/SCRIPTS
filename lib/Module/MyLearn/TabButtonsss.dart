import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';

class TabButtonsss extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onTabChange;

  const TabButtonsss({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(labels.length, (index) {
        final isSelected = selectedIndex == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnBordingContainer(
              width: double.infinity,
              height: 40.h,
              color: isSelected ? AppColors.primary : Colors.grey[100]!,
              widget: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => onTabChange(index),
            ),
          ),
        );
      }),
    );
  }
}
