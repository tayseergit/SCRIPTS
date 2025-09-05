import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // add this
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Helper/firebase_fun.dart';
import 'package:lms/Module/AddProject/View/pages/add_project_page.dart';
import 'package:lms/Module/Auth/View/Login.dart';
import 'package:lms/Module/Auth/View/register_page.dart';
import 'package:lms/Module/Auth/View/resetPassword_page.dart';
import 'package:lms/Module/Auth/cubit/auth_cubit.dart';
import 'package:lms/Module/Auth/cubit/forget_password_cubit.dart';
import 'package:lms/Module/CourseInfo/View/Pages/course_info_page.dart';
import 'package:lms/Module/Courses/View/Pages/courses_page.dart';
import 'package:lms/Module/Localization/localization.dart';
import 'package:lms/Module/More/more_page.dart';
import 'package:lms/Module/NavigationBarWidged/navigationBarWidget.dart';
import 'package:lms/Module/Project/View/Page/projectPage.dart';
import 'package:lms/Module/Setting/SettingPage.dart';
import 'package:lms/Module/Startup/View/Screen/splash_screen.dart';
import 'package:lms/Module/Stripe/stripe_page.dart';
// import 'package:lms/Module/Stripe/stripe_page.dart';
import 'package:lms/Module/StudentsProfile/View/Pages/student_profile_page.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/CourseTest/View/Pages/course_Test_Page.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/Course_content/View/Pages/course_conten_page.dart';
import 'package:lms/firebase_options.dart';

// Import your generated localization file
import 'generated/l10n.dart';

// Import the locale cubit you will create:

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   
    initLocalNotifications();
  await requestNotificationPermission();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await DioHelper.init();

  await getFcmToken();

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // التعامل مع أخطاء Flutter
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runZonedGuarded(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    runApp(const MyApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initStripe();
    setupForegroundMessageListener();
    setupOnMessageOpenedAppListener();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    print("token : ${CacheHelper.getToken()}");
    print("userid : ${CacheHelper.getUserId()}");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      locale: locale,
                      supportedLocales: S.delegate.supportedLocales,
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      theme: themeState.isDarkMode
                          ? ThemeData.dark()
                          : ThemeData.light(),
                      home: SplashScreen()
                      // home: CourseInfoPage(
                      //   testId: 1,
                      // courseId: 1,
                      // ),
                      );
                },
              );
            },
          );
        },
      ),
    );
  }
}
