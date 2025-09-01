import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lms/Constant/public_constant.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/generated/l10n.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;
  
  // Make startPayment static but pass context
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}



Future<void> startPayment(double amount,BuildContext context) async {
  if (amount <= 0) {
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('الرجاء إدخال مبلغ صالح')),
    );
    return;
  }

   

  try {
    final response = await DioHelper.postData(
      url: "charge",
      postData: {"amount": amount},
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${CacheHelper.getToken()}",
      },
    );

    final clientSecret = response.data['data']['client_secret'];

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'SCRIPTS',
        style: ThemeMode.light,
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    //  customSnackBar(context: context, success: 1, message: successMsg);
  } catch (e) {
    //  customSnackBar(context: context, success: 0, message: errorMsg);
  } finally {
    // if (Navigator.canPop(context)) {
    //   Navigator.pop(context);
    // }
  }
}

void showAmountDialog(BuildContext context) {
  final TextEditingController amountController = TextEditingController();
  bool localProcessing = false;

  showDialog(
    context: context,
    builder: (context) {
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
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء / Cancel'),
              ),
              ElevatedButton(
                onPressed: localProcessing
                    ? null
                    : () async {
                        setState(() => localProcessing = true);
                        final amount =
                            double.tryParse(amountController.text) ?? 0;
                        Navigator.pop(context); // Close dialog first

                        // Call startPayment from PaymentPage
                        startPayment(amount,context);
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
  Stripe.publishableKey ="${dotenv.env['STRIPE_KEY']}";
;
  Stripe.merchantIdentifier = 'merchant.com.yourapp';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
}
