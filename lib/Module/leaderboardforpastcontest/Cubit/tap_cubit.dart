import 'package:flutter_bloc/flutter_bloc.dart';

class TapLeadercubit extends Cubit<int> {
  TapLeadercubit() : super(0); 

  void changeTab(int index) => emit(index);
}