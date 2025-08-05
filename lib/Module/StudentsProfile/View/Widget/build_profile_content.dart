import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/achievement_gridView.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/certificate_gridVeiw.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/contest_profile_widget.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Header/main_header.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Tabs/info_tabs.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';

class BuildProfileContent extends StatelessWidget {
  BuildProfileContent({super.key, required this.cubit});
  StudentProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainHeader(
          cubit: cubit,
        ),
        SizedBox(height: 12.h),
        InfoTabs(
          cubit: cubit,
        ),
        SizedBox(height: 12.h),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: TabButtonsProfile(),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<StudentProfileCubit, StudentProfileState>(
          builder: (context, state) {
            // return Container();
            switch (cubit.selectedTab) {
              case 0:
                return CirtificateGridview(
                  cubit: cubit,
                );
              case 1:
                return AchievementGridview(cubit: cubit);
              case 2:
                return ContestHistoryCard(
                  cubit: cubit,
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
