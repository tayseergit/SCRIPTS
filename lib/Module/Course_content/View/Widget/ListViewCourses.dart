import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Course_content/Cubit/ContentCubit/course_content_cubit.dart';
import 'package:lms/Module/Course_content/Model/course_content_response.dart';
import 'package:lms/Module/Course_content/View/Widget/testCourseCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Course_content/View/Widget/CoursesVedioCard.dart';

class ListViewVediocourses extends StatelessWidget {
  ListViewVediocourses({super.key, required this.courseData});
  CourseData courseData;

  @override
  Widget build(BuildContext context) {
    List<VideoItem> videoItems = courseData.allContents
        .where((item) => item.type == "video")
        .cast<VideoItem>()
        .toList();

    List<TestItem> testItems = courseData.allContents
        .where((item) => item.type == "test")
        .cast<TestItem>()
        .toList();

    ThemeState appColors = context.watch<ThemeCubit>().state;

    int videoIndex = 0;
    int testIndex = 0;

    return Container(
      color: appColors.pageBackground,
      child: ListView.builder(
        itemCount: courseData.allContents.length,
        itemBuilder: (ctx, index) {
          final currentItem = courseData.allContents[index];

          if (currentItem.type == "video") {
            final videoItem = videoItems[videoIndex];
            videoIndex++;

            return Coursesvediocard(
              videoContentItem: videoItem,
              index: videoIndex,
            );
          } else if (currentItem.type == "test") {
            final testItem = testItems[testIndex];
            testIndex++;

            return TestCourseCard(testItem: testItem,index: testIndex);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
