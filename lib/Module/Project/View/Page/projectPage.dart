import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Project/Cubit/project_cubit.dart';
import 'package:lms/Module/Project/Cubit/project_state.dart';
import 'package:lms/Module/Project/View/Widget/Swich.dart';
import 'package:lms/Module/Project/View/Widget/TapProject.dart';
import 'package:lms/Module/Project/View/Widget/TapBarCubit.dart';
import 'package:lms/Module/Project/View/Widget/TapBarPage.dart';
import 'package:lms/Module/Project/View/Widget/gridViewProject.dart';
import 'package:lms/Module/Project/View/Widget/grid_loading.dart';
import 'package:lms/Module/Project/View/Widget/toggle_switch.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/leaderboardforpastcontest/LeaderListView.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';
import 'package:lms/Module/mainWidget/loading_container.dart';

class Projectpage extends StatelessWidget {
  const Projectpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final search = TextEditingController();

    return SafeArea(
      child: BlocProvider(
        create: (context) => ProjectCubit()..getProjectsTags(),
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            toolbarHeight: 70.h,
            scrolledUnderElevation: 0,
            backgroundColor: appColors.pageBackground,
            elevation: 0,
            title: Align(
              alignment: Alignment.center,
              child: AuthText(
                text: 'Project',
                size: 24,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BlocConsumer<ProjectCubit, ProjectState>(
            listener: (context, state) {},
            builder: (context, state) {
              final projectCubit = context.watch<ProjectCubit>();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 220.w,
                            child: Customtextfieldsearsh(
                              onSubmit: () {
                                projectCubit.getProjects();
                              },
                              controller: projectCubit.searchController,
                              hintText: 'search project ...',
                            ),
                          ),

                          // Tap  Prosject(),
                          SizedBox(
                              height: 50.h,
                              width: 100.w,
                              child: ToggleExample(
                                projectCubit: projectCubit,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Builder(
                        builder: (context) {
                          if (state is TagsLoading) return LoadingContainer();
                          if (state is Error || projectCubit.selectedkind == 1)
                            return Container();
                          return TabButtonsProject(
                            cubit: projectCubit,
                          );
                        },
                      ),
                      SizedBox(height: 10.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Builder(
                          builder: (context) {
                            print(state);
                            if (state is ProjectLoading ||
                                state is TagsLoading) {
                              return GridviewLoading();
                            } else if (state is ProjectSuccess) {
                              if (projectCubit
                                  .projectsResponse!.data.isNotEmpty) {
                                return Gridviewproject(
                                    projectModel:
                                        projectCubit.projectsResponse!.data);
                              } else
                                return Center(
                                    heightFactor: 2.5, child: NoItem());
                            }
                            return NoConnection();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
