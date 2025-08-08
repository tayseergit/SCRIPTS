import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<bool> {
  CommentCubit() : super(false); 

  void toggleExpand() => emit(!state);
}
