import 'package:flutter_bloc/flutter_bloc.dart';

class Tapcubit extends Cubit<int> {
  Tapcubit() : super(0); 

  void changeTab(int index) => emit(index);
}