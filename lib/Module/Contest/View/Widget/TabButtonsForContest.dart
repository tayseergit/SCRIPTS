import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Contest/Cubit/contest_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ContestTab extends StatelessWidget {
  final ContestCubit contestCubit;

  ContestTab({super.key, required this.contestCubit});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    final icons = [
      Images.contest3,
      Images.contest2,
      Images.contest1,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(contestCubit.getLabels(context).length, (index) {
        final isSelected = contestCubit.selectedTab == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnBoardingContainer(
              radius: 15,
              width: double.infinity,
              height: 45.h,
              color: isSelected ? appColors.primary : appColors.pageBackground,
              widget: AnimatedAlign(
                duration: const Duration(milliseconds: 500),
                alignment: Alignment.center,
                curve: Curves.easeInOut,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: isSelected
                      ? Padding(
                          key: ValueKey('text_$index'),
                          padding: EdgeInsets.all(1),
                          child: Text(
                            contestCubit.getLabels(context)[index],
                            style: TextStyle(
                              color: appColors.whiteText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Image.asset(
                          icons[index],
                          key: ValueKey('icon_$index'),
                          width: index == 0
                              ? 30
                              : index == 1
                                  ? 26
                                  : 18,
                          height: index == 0
                              ? 30
                              : index == 1
                                  ? 26
                                  : 18,
                          color: appColors.darkGreen,
                        ),
                ),
              ),
              onTap: () {
                contestCubit.changeTab(index);
              },
            ),
          ),
        );
      }),
    );
  }
}
