// lib/Module/Courses/page/courses_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lms/Module/Contest/Cubit/contest_cubit.dart';
import 'package:lms/Module/Contest/Cubit/contest_state.dart';
import 'package:lms/Module/Contest/View/Widget/ContestCard.dart';
import 'package:lms/Module/Contest/View/Widget/TabButtonsForContest.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/Errors/no-item.dart';
import 'package:lms/Module/mainWidget/Errors/no_connection.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';
import 'package:lms/Module/mainWidget/loading.dart';

import '../../../../generated/l10n.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({super.key});

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  late ContestCubit contestCubit;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    contestCubit = ContestCubit()..getContest();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        contestCubit.getContest(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    contestCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => ContestCubit()..getContest(),
      child: SafeArea(
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
                text: S.of(context).Contest,
                size: 24,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BlocConsumer<ContestCubit, ContestState>(
            listener: (context, state) {},
            builder: (context, state) {
              final contestCubit = context.watch<ContestCubit>();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                child: ListView(
                  children: [
                    Customtextfieldsearsh(
                      onSubmit: () {
                        contestCubit.getContest();
                      },
                      controller: contestCubit.searchController,
                      hintText: S.of(context).choose_contest,
                    ),
                    SizedBox(height: 15.h),
                    ContestTab(
                      contestCubit: contestCubit,
                    ),
                    SizedBox(height: 10.h),
                    Builder(
                      builder: (context) {
                        print(state);
                        if (state is ContestLoading) {
                          return SizedBox(
                            height: 500.h,
                            child: Center(child: Loading()),
                          );
                        } else if (state is ContestError) {
                          return SizedBox(
                            height: 500.h,
                            child: Center(child: NoConnection()),
                          );
                        }

                        final contests =
                            contestCubit.contestResponse?.contests ?? [];

                        if (contests.isEmpty) {
                          return Center(
                            heightFactor: 2.5,
                            child: SizedBox(
                              height: 200.h,
                              child: NoItem(),
                            ),
                          );
                        }

                        return Column(
                          children: [
                            Container(
                              height: 515.h,
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: contests.length +
                                    (contestCubit.isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index >= contests.length) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  return TweenAnimationBuilder<double>(
                                    key: ValueKey(contests[index].id),
                                    tween: Tween<double>(begin: 50, end: 0),
                                    duration: Duration(
                                        milliseconds:
                                            800 + ((index % 10) * 50)),
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
                                    child:
                                        Contestcard(contest: contests[index]),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
