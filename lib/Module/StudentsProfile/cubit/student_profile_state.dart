part of 'student_profile_cubit.dart';

@immutable
abstract class StudentProfileState {}

class StudentProfileInitial extends StudentProfileState {}

class ProfileLoading extends StudentProfileState {}

class ProfileError extends StudentProfileState {
  final String message;
  ProfileError({required this.message});
}

class ProfileSuccess extends StudentProfileState {
  final StudentProfileModel student;

  ProfileSuccess(this.student);
}
