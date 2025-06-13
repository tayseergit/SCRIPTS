// lib/Module/Courses/widget/tab_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/View/Widget/Container.dart';
import 'package:lms/Module/Auth/View/Widget/authText.dart';
import 'package:lms/Module/Contest/TabbuttonsforcontestCubit.dart';

class Tabbuttonsforcontest extends StatelessWidget {
  const Tabbuttonsforcontest({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.watch<TabbuttonsforcontestCubit>().state;

    final labels = ['Active', 'Upcoming', 'Past'];
    final icons = [
      Images.contest2,
      Images.contest1,
      Images.contest3,
    ];
    final counts = [2, 5, 3];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (index) {
        final isSelected = selectedTab == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnBordingContainer(
              width: double.infinity,
              height: 45.h,
              color: isSelected ? AppColors.primary : Colors.grey[100]!,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    icons[index],
                    width: index == 2 ? 26 : 18,
                    height: index == 2 ? 26 : 18,
                    color:
                        isSelected
                            ? AppColors.white
                            : AppColors.black,
                  ),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.ok,
                    radius: 10,
                    child: AuthText(
                      text: counts[index].toString(),
                      size: 10,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              onTap:
                  () => context.read<TabbuttonsforcontestCubit>().changeTabbb(
                    index,
                  ),
            ),
          ),
        );
      }),
    );
  }
}
