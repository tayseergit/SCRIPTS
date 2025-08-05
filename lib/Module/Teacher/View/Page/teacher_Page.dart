import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Teacher/Cubit/teacher_cubit.dart';
import 'package:lms/Module/Teacher/Cubit/teacher_state.dart';
import 'package:lms/Module/Teacher/View/Widget/gridview_teacher.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';

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
          listener: (context, state) {
            if (state is TeacherError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.masseg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TeacherLoding &&
                context.read<TeacherCubit>().lastUsers == null) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TeacherError) {
              return Center(
                child: Text(
                  state.masseg,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              final teacherList =
                  context.read<TeacherCubit>().lastUsers?.users ?? [];

              return ListView(
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
                            context.read<TeacherCubit>().searchTeacher(query);
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
              );
            }
          },
        ),
      ),
    );
  }
}
