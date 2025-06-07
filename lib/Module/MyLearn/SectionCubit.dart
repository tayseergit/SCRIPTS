import 'package:flutter_bloc/flutter_bloc.dart';

class SectionCubit extends Cubit<int> {
  SectionCubit() : super(0); // 0 => Courses, 1 => Path
  void changeSection(int index) => emit(index);
}
