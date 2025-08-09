import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Course_content/Model/course_content_response.dart';
import 'package:lms/Module/Course_content/View/Widget/content/CoursesVideoCard.dart';
import 'package:lms/Module/Course_content/View/Widget/content/testCourseCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
 
class ListViewVediocourses extends StatelessWidget {
  ListViewVediocourses({super.key, required this.courseData});
  CourseData courseData;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    int videoIndex = 0;
    int testIndex = 0;

    return Container(
      color: appColors.pageBackground,
      child: ListView.builder(
        itemCount: courseData.allContents.length,
        itemBuilder: (ctx, index) {
          if (courseData.allContents[index].type == "test") {
            return TestCourseCard(
              testItem: courseData.allContents[index],courseId: courseData.id
            );
          } else {
            return Coursesvideocard(
              videoContentItem: courseData.allContents[index],courseId: courseData.id,
            );
          }
        },
      ),
    );
  }
}
