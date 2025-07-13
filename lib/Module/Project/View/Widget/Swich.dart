import 'package:flutter_bloc/flutter_bloc.dart';

class Swich extends Cubit<int> {
  Swich() : super(0);

  void changeTab(int index) => emit(index);
}
