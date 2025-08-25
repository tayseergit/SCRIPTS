import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/LearnPath/Cubit/learn_path_cubit.dart';
import 'package:lms/Module/LearnPath/View/Widget/LearnPathCard.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class Gridviewlearnpath extends StatefulWidget {
  final LearnPathCubit cubit;
  const Gridviewlearnpath({super.key, required this.cubit});

  @override
  State<Gridviewlearnpath> createState() => _GridviewlearnpathState();
}

class _GridviewlearnpathState extends State<Gridviewlearnpath> {
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
      widget.cubit.getAllLearnPath();
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

    return BlocBuilder<LearnPathCubit, LearnPathState>(
      bloc: cubit,
      builder: (context, state) {
        final learningPaths = cubit.allLearningPaths;
        final showLoader = cubit.isLoading && learningPaths.isNotEmpty;

        return Container(
          height: 530.h,
          color: appColors.pageBackground,
          child: GridView.builder(
            controller: _scrollController,
            itemCount: learningPaths.length + (showLoader ? 1 : 0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400.h,
              childAspectRatio: 1,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 20.w,
            ),
            itemBuilder: (ctx, index) {
              if (index >= learningPaths.length) {
                return const Center(child: CircularProgressIndicator());
              }

              // Add ease-out animation
              return TweenAnimationBuilder<double>(
                key: ValueKey(learningPaths[index].id),
                tween: Tween<double>(begin: 50, end: 0), // distance from right
                duration: Duration(milliseconds: 800 + ((index % 10) * 50)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0), // X-axis movement
                    child: Opacity(
                      opacity: 1 - (value / 50),
                      child: child,
                    ),
                  );
                },
                child: LearnpathCard(learnPath: learningPaths[index]),
              );
            },
          ),
        );
      },
    );
  }
}
