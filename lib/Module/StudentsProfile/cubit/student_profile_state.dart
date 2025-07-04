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

/// cetificate

class CertificatesLoading extends StudentProfileState {}

class CertificatesError extends StudentProfileState {
  final String message;
  CertificatesError({required this.message});
}

class CertificatesSuccess extends StudentProfileState {}
/// achievement
/// 

class AchievementLoading extends StudentProfileState {}

class AchievementError extends StudentProfileState {
  final String message;
  AchievementError({required this.message});
}

class AchievementSuccess extends StudentProfileState {}


///// 
/// contest

class ContestLoading extends StudentProfileState {}

class ContestError extends StudentProfileState {
  final String message;
  ContestError({required this.message});
}

class ContestSuccess extends StudentProfileState {}


/// 
class Selected extends StudentProfileState {}
