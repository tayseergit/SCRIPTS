import 'package:flutter_bloc/flutter_bloc.dart';

class CardExpandCubit extends Cubit<bool> {
  CardExpandCubit() : super(false);

  void toggle() => emit(!state);
}
