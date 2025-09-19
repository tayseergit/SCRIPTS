import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/StudentsProfile/Model/student_profile_model.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/achievement_gridView.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/certificate_gridVeiw.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Header/main_header_student.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Tabs/info_tabs.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/contest_profile_widget.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/build_profile_content.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/mainWidget/loading.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';

class StudentProfilePage extends StatelessWidget {
  StudentProfilePage({super.key, required this.userid});
  int userid;

  StudentProfileModel? studentProfileModel;

  @override
  @override
  Widget build(BuildContext context) {
    final appColors = context.read<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => StudentProfileCubit()..getProfile(userid),
      child: BlocConsumer<StudentProfileCubit, StudentProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {}
          if (state is ProfileSuccess) {
            studentProfileModel = state.student;
            print(studentProfileModel?.name);
          }
        },
        builder: (context, state) {
          StudentProfileCubit studentProfileCubit =
              context.read<StudentProfileCubit>();

          return SafeArea(
            child: Scaffold(
              backgroundColor: appColors.pageBackground,
              body: Builder(
                builder: (context) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: SizedBox(
                        height: 80.h,
                        child: Loading(height: 50.h, width: 50.w),
                      ),
                    );
                  } else if (state is ProfileError) {
                    return Center(
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: NoConnection(),
                      ),
                    );
                  } else if (state is NoAuth) {
                    return Center(
                      child: SizedBox(
                        child: NoAuthUser(),
                      ),
                    );
                  }
                  // Default: display the profile content
                  return BuildProfileContent(cubit: studentProfileCubit);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
