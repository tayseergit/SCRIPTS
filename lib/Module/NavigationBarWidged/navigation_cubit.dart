import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(3);
  void changePage(int index) => emit(index);
}
