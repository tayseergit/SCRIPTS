import 'package:lms/Module/Teacher/Model/teacher_model.dart';

abstract class ParticipantsState {}

class ParticpantsInitial extends ParticipantsState {}

class ParticpantsSuccess extends ParticipantsState {
  final UsersResponse usersResponse;

  ParticpantsSuccess({required this.usersResponse});
}

class ParticpantsLoding extends ParticipantsState {}

class ParticpantsError extends ParticipantsState {
  final String masseg;
  ParticpantsError({required this.masseg});
}

class ParticpantsAddSuccess extends ParticipantsState {}

class ParticpantsLoadingCards extends ParticipantsState {}
class UnAuth extends ParticipantsState {}
