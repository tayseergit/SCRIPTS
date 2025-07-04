import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCubit extends Cubit<bool> {
  ReviewCubit() : super(false); 

  void toggleExpand() => emit(!state);
}
