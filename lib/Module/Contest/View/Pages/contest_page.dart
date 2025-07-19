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

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});

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
                text: 'Contest',
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
                      hintText: 'get contest ?',
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
                            child: Center(child: Container()),
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

                        return SizedBox(
                          height: 560.h,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 40.0),
                            child: ListView.builder(
                              itemCount: contests.length,
                              itemBuilder: (context, index) {
                                return Contestcard(
                                  contest: contestCubit
                                      .contestResponse!.contests[index],
                                );
                              },
                            ),
                          ),
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
