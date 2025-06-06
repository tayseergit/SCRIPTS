abstract class VerifyState {}

class VerifyCubitInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifySucsses extends VerifyState {}

class VerifyErrorConnection extends VerifyState {
  final String message;
  VerifyErrorConnection({required this.message});
}

class VerifyErrorCode extends VerifyState {}
