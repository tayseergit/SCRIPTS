import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/Model/CertificatesModel.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Cards/achievements_card.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Cards/cetificate_card.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
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
              return Center(child: NoItem());
            }
            return SizedBox(
              height: 220.h, // Adjust to match the card height
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Only 1 row for horizontal scroll
                  mainAxisSpacing: 15.w,
                  childAspectRatio: 1.2, // Adjust width/height ratio
                ),
                itemCount: Ach_List.length,
                itemBuilder: (ctx, index) {
                  return AchievementCard(
                    achievement: Ach_List[index],
                  );
                },
              ),
            );
          } else {
            return const SizedBox(); // Initial or unknown state
          }
        },
      ),
    );
  }
}
