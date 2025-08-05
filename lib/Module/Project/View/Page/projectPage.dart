import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Module/AddProject/View/pages/add_project_page.dart';
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
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/generated/l10n.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    var lang = S.of(context);
    return SafeArea(
      child: BlocProvider(
        create: (context) => ProjectCubit()..getProjectsTags(context),
        lazy: true,
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            toolbarHeight: 70.h,
            scrolledUnderElevation: 0,
            backgroundColor: appColors.pageBackground,
            elevation: 0,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Title at the start
                  Expanded(
                    child: Center(
                      child: AuthText(
                        text: lang.Project,
                        size: 24.sp,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  // Container with text at the end
                  InkWell(
                    onTap: () {
                      // CacheHelper.removeAllData();
                      if (CacheHelper.getToken() == null) {
                        showNoAuthDialog(context);
                      } else {
                        pushTo(context: context, toPage: AddProjectPage());
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 50.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: appColors.lihgtPrimer, // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        color: appColors.mainIconColor,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: BlocConsumer<ProjectCubit, ProjectState>(
            listener: (context, state) {
              if (state is Error) {
                print("++++++++++ $state");
                // ScaffoldMessenger.of(context).showSnackBar(state.message);
              }
            },
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
                                projectCubit.getProjects(context);
                              },
                              controller: projectCubit.searchController,
                              hintText: lang.search_project,
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
                          if (state is Error ||
                              projectCubit.selectedkind == 1) {
                            return Container();
                          }
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
                              } else {
                                return Center(
                                    heightFactor: 2.5, child: NoItem());
                              }
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
