import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:flutter/material.dart';
import 'package:lms/Module/payment/cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> startPayment(double amount, BuildContext context) async {
    if (amount <= 0) {
      emit(PaymentAmountFailure());
      return;
    }

    emit(PaymentLoading());

    try {
      final response = await DioHelper.postData(
        url: "charge",
        postData: {"amount": amount},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      );

      if (response.statusCode == 401) {
        print(response.data['message']);
        showNoAuthDialog(context);
        emit(PaymentFailure(response.data['message']));
        return;
      }

      final clientSecret = response.data['data']['client_secret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'SCRIPTS',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      emit(PaymentSuccess("تم الدفع بنجاح ✅"));
    } catch (e) {
      emit(PaymentFailure("حدث خطأ أثناء الدفع: $e"));
      print("حدث خطأ أثناء الدفع:$e.");
    }
  }
}
