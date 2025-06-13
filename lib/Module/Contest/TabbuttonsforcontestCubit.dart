
import 'package:flutter_bloc/flutter_bloc.dart';

class TabbuttonsforcontestCubit extends Cubit<int> {
  TabbuttonsforcontestCubit() : super(0); 

  void changeTabbb(int index) => emit(index);
}
