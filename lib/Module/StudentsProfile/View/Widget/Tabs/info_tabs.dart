import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';

class InfoTabs extends StatelessWidget {
  InfoTabs({super.key, required this.cubit});
  StudentProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Profilestate(
              title: 'Current Streak',
              value: '${cubit.studentProfileModel.points} Days'),
          Profilestate(
              title: 'Course Completed',
              value: "${cubit.studentProfileModel.completedCourses}"),
          Profilestate(
              title: 'Total Points',
              value: "${cubit.studentProfileModel.points}"),
        ],
      ),
    );
  }
}
