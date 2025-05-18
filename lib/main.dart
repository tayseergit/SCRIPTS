import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/cubit/app_color_cubit.dart';
import 'package:lms/Module/Auth/cubit/app_color_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(), 
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(411, 823),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: const Login(), 
              );
            },
          );
        },
      ),
    );
  }
}
