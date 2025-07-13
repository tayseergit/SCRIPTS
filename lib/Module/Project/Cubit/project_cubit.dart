import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:lms/Module/Project/Cubit/project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());


  int selectedType=0;
  
  void loadProjectsFromJson() {
    try {
      emit(ProjectLoading());

  }
}
}