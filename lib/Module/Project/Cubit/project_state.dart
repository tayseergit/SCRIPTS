import 'package:equatable/equatable.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectSuccess extends ProjectState {}

 

class Selected extends ProjectState {}

class TagsLoading extends ProjectState {}

class TagsSuccess extends ProjectState {}

class Error extends ProjectState {
final String message;

Error({required this.message});
}
