import 'package:flutter_bloc/flutter_bloc.dart';

class CardExpandCubit extends Cubit<Map<int, bool>> {
  CardExpandCubit() : super({});

  void toggle(int index) {
    final newState = Map<int, bool>.from(state);
    newState[index] = !(newState[index] ?? false);
    emit(newState);
  }
}
