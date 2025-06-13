import 'package:flutter_bloc/flutter_bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(0); 

  void changeTab(int index) => emit(index);
}
class TabCubitProfile extends Cubit<int> {
  TabCubitProfile() : super(0); 

  void changeTab(int index) => emit(index);
}
