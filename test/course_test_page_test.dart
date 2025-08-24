import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/ContestTest/View/Widget/GridViewTest.dart';

 import 'package:lms/Module/CourseTest/View/Pages/course_Test_Page.dart';
import 'package:lms/Module/CourseTest/cubit/course_test_cubit.dart';

Widget makeTestableWidget(Widget child, Size screenSize) {
  return ScreenUtilInit(
    designSize: screenSize, // simulate design size
    builder: (context, _) {
      return MaterialApp(
        home: BlocProvider(
          create: (_) => CourseTestCubit(testId: 1, courseId: 1),
          child: child,
        ),
      );
    },
  );
}

void main() {
  group('CourseTestPage Responsive Tests', () {
    testWidgets('renders correctly on small phone', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 2.0;

      await tester.pumpWidget(
        makeTestableWidget(CourseTestPage(testId: 1, courseId: 1), const Size(360, 640)),
      );

      expect(find.byType(Scaffold), findsOneWidget);

      // Ensure the "Next" button is present
      expect(find.textContaining('Next'), findsOneWidget);

      // Cleanup
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
    });

    testWidgets('renders correctly on large phone', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 1600);
      tester.binding.window.devicePixelRatioTestValue = 3.0;

      await tester.pumpWidget(
        makeTestableWidget(CourseTestPage(testId: 1, courseId: 1), const Size(800, 1600)),
      );

      expect(find.byType(Scaffold), findsOneWidget);

      // Title should still be visible
      expect(find.textContaining('Test'), findsWidgets);

      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
    });

    testWidgets('renders correctly on tablet', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 1920);
      tester.binding.window.devicePixelRatioTestValue = 2.0;

      await tester.pumpWidget(
        makeTestableWidget(CourseTestPage(testId: 1, courseId: 1), const Size(1200, 1920)),
      );

      expect(find.byType(Scaffold), findsOneWidget);

      // Ensure GridView of answers is visible
      expect(find.byType(GridViewTestAnswers), findsOneWidget);

      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
    });
  });
}
