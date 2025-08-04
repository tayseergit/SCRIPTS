import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Project/Cubit/project_cubit.dart';
import 'package:lms/Module/Project/Cubit/project_state.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/generated/l10n.dart';

class ToggleExample extends StatelessWidget {
  final ProjectCubit projectCubit;

  const ToggleExample({Key? key, required this.projectCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    // Listen to ProjectCubit state changes to rebuild the toggle
    return BlocBuilder<ProjectCubit, ProjectState>(
      bloc: projectCubit,
      builder: (context, state) {
        int selectedKind = projectCubit.selectedkind;

        return Center(
          child: AnimatedToggleSwitch<int>.size(
            current: selectedKind,
            values: [0, 1],
            iconOpacity: 0.2,
            indicatorSize: const Size.fromWidth(100),
            style: ToggleStyle(
              borderColor: Colors.grey,
              backgroundColor: Colors.grey.shade300,
              indicatorColor: appColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            styleBuilder: (i) => ToggleStyle(
              indicatorColor:
                  i == 0 ? appColors.darkGreen : appColors.lihgtPrimer,
            ),
            iconBuilder: (value) {
              return Text(
                value == 0 ? S.of(context).All : S.of(context).My,
                style: TextStyle(
                    color: value == selectedKind ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp),
              );
            },
            onChanged: (i) {
              projectCubit.changeKind(i, context); // Notify cubit
            },
          ),
        );
      },
    );
  }
}
