import 'package:flutter_bloc/flutter_bloc.dart';

class CourseTabCubit extends Cubit<int> {
  CourseTabCubit() : super(0);
  void changeTab(int index) => emit(index);
}

class PathTabCubit extends Cubit<int> {
  PathTabCubit() : super(0);
  void changeTab(int index) => emit(index);
}
