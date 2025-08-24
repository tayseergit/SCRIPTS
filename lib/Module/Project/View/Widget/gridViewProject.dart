import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Project/Cubit/project_cubit.dart';
import 'package:lms/Module/Project/Cubit/project_state.dart';
import 'package:lms/Module/Project/Model/projet_response.dart';
import 'package:lms/Module/Project/View/Widget/ProjectCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewproject extends StatefulWidget {
  final ProjectCubit projectCubit;
  const Gridviewproject({super.key, required this.projectCubit});

  @override
  State<Gridviewproject> createState() => _GridviewprojectState();
}

class _GridviewprojectState extends State<Gridviewproject> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      widget.projectCubit.getAllProjects(context);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    final cubit = widget.projectCubit;

    return BlocBuilder<ProjectCubit, ProjectState>(
      bloc: cubit,
      builder: (context, state) {
        final projects = cubit.allProjects;
        final showLoader = cubit.isLoading && projects.isNotEmpty;

        return SizedBox(
          height: 520.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  cubit.selectedTab > -1 && cubit.tagResponse != null
                      ? "${Images.baseImages}${cubit.tagResponse!.tags[cubit.selectedTab].name.replaceAll(' ', '')}image.png"
                      : Images.webImage,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: appColors.pageBackground.withOpacity(0.85),
                child: GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 17.h, bottom: 17.h),
                  itemCount: projects.length + (showLoader ? 1 : 0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250.h,
                    childAspectRatio: 175 / 255,
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemBuilder: (ctx, index) {
                    if (index >= projects.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Projectcard(projectModel: projects[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
