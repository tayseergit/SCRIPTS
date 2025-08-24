import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(2);

  void changePage(int index) => emit(index);
}
