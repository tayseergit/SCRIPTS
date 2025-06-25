import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/Model/CertificatesModel.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/achievements_card.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/cetificate_card.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class AchievementGridview extends StatefulWidget {
  final StudentProfileCubit cubit;

  const AchievementGridview({super.key, required this.cubit});

  @override
  State<AchievementGridview> createState() => _AchievementGridviewState();
}

class _AchievementGridviewState extends State<AchievementGridview> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      widget.cubit.getAchievement();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return SizedBox(
      height: 350.h,
      child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
        builder: (context, state) {
          if (state is AchievementLoading) {
            return Center(
              child: SizedBox(
                  height: 100.h, child: Loading(height: 50.h, width: 50.h)),
            );
          } else if (state is AchievementError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: appColors.red),
              ),
            );
          } else if (state is AchievementSuccess) {
            final Ach_List =
                widget.cubit.achievementResponse.achievements ?? [];
            if (Ach_List.isEmpty) {
              return Center(
                child: Text(
                  "No Achievement",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appColors.mainText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.only(top: 7.h, left: 10.w, right: 10.w),
              itemCount: Ach_List.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220.w,
                childAspectRatio: 1,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 5.w,
              ),
              itemBuilder: (ctx, index) {
                // Use real data in your actual card
                return AchievementCard(
                  achievement: Ach_List[index],
                );
              },
            );
          } else {
            return const SizedBox(); // Initial or unknown state
          }
        },
      ),
    );
  }
}
