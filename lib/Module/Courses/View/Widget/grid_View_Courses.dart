import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Courses/Cubit/cubit/course_cubit.dart';
import 'package:lms/Module/Courses/View/Widget/courses_card.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewcourses extends StatefulWidget {
  final CourseCubit cubit;
  const Gridviewcourses({super.key, required this.cubit});

  @override
  State<Gridviewcourses> createState() => _GridviewcoursesState();
}

class _GridviewcoursesState extends State<Gridviewcourses> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      widget.cubit.getAllCourse();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    final cubit = widget.cubit;

    return BlocBuilder<CourseCubit, CourseState>(
      bloc: cubit,
      builder: (context, state) {
        final courses = cubit.allCourses;
        final showLoader = cubit.isLoading && courses.isNotEmpty;

        return Container(
          height: 525.h,
          color: appColors.pageBackground,
          child: GridView.builder(
            controller: _scrollController,
            itemCount: courses.length + (showLoader ? 1 : 0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180.w,
              childAspectRatio: 150.w / 250.h,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 10.w,
            ),
            itemBuilder: (ctx, index) {
              if (index >= courses.length) {
                return const Center(child: CircularProgressIndicator());
              }

              // Animate each grid item
              return TweenAnimationBuilder<double>(
                key: ValueKey(courses[index].id),
                tween: Tween<double>(begin: 50, end: 0),
                duration: Duration(milliseconds: 800 + ((index % 10) * 50)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, value),
                    child: Opacity(
                      opacity: 1 - (value / 50),
                      child: child,
                    ),
                  );
                },
                child: Cursescard(course: courses[index]),
              );
            },
          ),
        );
      },
    );
  }
}
