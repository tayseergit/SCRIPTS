part of 'add_project_cubit.dart';

class AddProjectState {}

class AddProjectInitial extends AddProjectState {}

class TagsLoading extends AddProjectState {}

class TagsSuccess extends AddProjectState {}

class AddProjectLoading extends AddProjectState {}

class AddProjectSuccess extends AddProjectState {}

class AddProjectError extends AddProjectState {
  final String message;

  AddProjectError({required this.message});
}
