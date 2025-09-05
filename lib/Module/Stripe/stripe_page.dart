import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/mainWidget/no_auth.dart';
import 'package:lms/Module/payment/cubit/payment_state.dart';
import 'package:lms/Module/payment/cubit/puyment_cubit.dart';
import 'package:lms/generated/l10n.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentFailure) {
          customSnackBar(context: context, success: 0, message: state.error);
        } else if (state is PaymentSuccess) {
          customSnackBar(context: context, success: 1, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: ElevatedButton(
            onPressed: () {
              showAmountDialog(context);
            },
            child: const Text("ادفع الآن"),
          ),
        );
      },
    );
  }
}

void showAmountDialog(BuildContext parentContext) {
  final TextEditingController amountController = TextEditingController();
  bool localProcessing = false;

  showDialog(
    context: parentContext, // 👈 use parent context
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('أدخل المبلغ / Enter Amount'),
            content: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'المبلغ (\$) / Amount (\$)',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('إلغاء / Cancel'),
              ),
              ElevatedButton(
                onPressed: localProcessing
                    ? null
                    : () async {
                        setState(() => localProcessing = true);

                        final amount =
                            double.tryParse(amountController.text) ?? 0;

                        Navigator.pop(dialogContext); // close dialog only

                        // 👇 pass parentContext, not dialogContext
                        parentContext
                            .read<PaymentCubit>()
                            .startPayment(amount, parentContext);
                      },
                child: localProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('دفع / Pay'),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> initStripe() async {
  Stripe.publishableKey = "${dotenv.env['STRIPE_KEY']}";
  print(dotenv.env['STRIPE_KEY']);

  Stripe.merchantIdentifier = 'merchant.com.yourapp';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  print("strip init");
}
