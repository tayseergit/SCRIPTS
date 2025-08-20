import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Teacher/Cubit/teacher_cubit.dart';
import 'package:lms/Module/Teacher/Cubit/teacher_state.dart';
import 'package:lms/Module/Teacher/View/Widget/gridview_teacher.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/TopWave_more_Clipper.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/loading_container.dart';
import 'package:lms/generated/l10n.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TeacherCubit()..fetchAllTeacher()),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<TeacherCubit, TeacherState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TeacherLoding &&
                context.read<TeacherCubit>().lastUsers == null) {
              return Center(
                child: SizedBox(
                  height: 80.h,
                  child: Loading(height: 50.h, width: 50.w),
                ),
              );
            } else if (state is TeacherError) {
              return Center(child: NoConnection());
            } else {
              final teacherList =
                  context.read<TeacherCubit>().lastUsers?.users ?? [];

              return Stack(
                children: [
                  ClipPath(
                    clipper: TopWaveMoreClipper(),
                    child: Container(
                      decoration: BoxDecoration(gradient: appColors.linear),
                      width: double.infinity,
                      height: 250.h,
                    ),
                  ),
                  Positioned(
                    top: 60.h,
                    left: 16.w,
                    child: AuthText(
                      text: S.of(context).teachers,
                      size: 30,
                      color: appColors.mainText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      SizedBox(height: 140.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Customtextfieldsearsh(
                            onChanged: (value) {
                              final query = value.trim();
                              if (query.isNotEmpty) {
                                context
                                    .read<TeacherCubit>()
                                    .searchTeacher(query);
                              } else {
                                context.read<TeacherCubit>().fetchAllTeacher();
                              }
                            },
                            borderRadius: 6,
                            controller: search,
                            borderColor: appColors.primary,
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              size: 30,
                              color: appColors.iconSearsh,
                            ),
                            suffixIcon: Image.asset(
                              Images.filter,
                              width: 17.w,
                              height: 17.h,
                              color: appColors.iconSearsh,
                            ),
                            hintText: 'which teacher?',
                            hintFontSize: 13.sp,
                            hintFontWeight: FontWeight.w600,
                            fillColor: appColors.pageBackground,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Gridviewteacher(teacher: teacherList)
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
