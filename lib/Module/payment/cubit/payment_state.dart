 
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PaymentState {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}
class PaymentAmountFailure extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String message;
  PaymentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PaymentFailure extends PaymentState {
  final String error;
  PaymentFailure(this.error);

  @override
  List<Object?> get props => [error];
}
