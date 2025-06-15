import 'package:flutter_bloc/flutter_bloc.dart';

class Tabteachercubit extends Cubit<int> {
  Tabteachercubit() : super(0); 

  void changeTab(int index) => emit(index);
}