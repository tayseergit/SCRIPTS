import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/generated/l10n.dart';

class InfoTabs extends StatelessWidget {
  InfoTabs({super.key, required this.cubit});
  StudentProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Profilestate(
                title: lang.current_streak,
                value: '${cubit.studentProfileModel.points} ${lang.days}'),
          ),
          Expanded(
            child: Profilestate(
                title: lang.course_completed,
                value: "${cubit.studentProfileModel.completedCourses}"),
          ),
          Expanded(
            child: Profilestate(
                title: lang.total_points,
                value: "${cubit.studentProfileModel.points}"),
          ),
           
        ],
      ),
    );
  }
}
