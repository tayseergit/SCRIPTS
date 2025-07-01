import 'package:flutter_bloc/flutter_bloc.dart';

class AboutthisPathCubit extends Cubit<bool> {
  AboutthisPathCubit() : super(false);

  void toggleExpand() => emit(!state);
}

class TeacherCubit extends Cubit<bool> {
  TeacherCubit() : super(false);

  void toggleExpand() => emit(!state);
}
