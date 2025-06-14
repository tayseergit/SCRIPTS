import 'package:flutter_bloc/flutter_bloc.dart';

class TapbarcubitProject extends Cubit<int> {
  TapbarcubitProject() : super(0); 

  void changeTab(int index) => emit(index);
}