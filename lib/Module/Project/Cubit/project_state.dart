import 'package:equatable/equatable.dart';
 
abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectSuccess extends ProjectState {}

class ProjectError extends ProjectState {
  final String message;

  ProjectError({required this.message});
}
