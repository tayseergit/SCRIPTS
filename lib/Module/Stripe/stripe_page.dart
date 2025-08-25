// import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _amountController = TextEditingController();
  bool _isProcessing = false;

  Future<void> _startPayment() async {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount')),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid amount')),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // 1. Call backend to create PaymentIntent
      final response = await DioHelper.postData(
        url: "charge",
        postData: {"amount": 200, "payment_method_id": "pm_card_visa"},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getToken()}",
        },
      );
      print(response.statusCode);
      final clientSecret = response.data['data']['client_secret'];
      print('ClientSecret: ${response.data['data']['client_secret']}');
      if (clientSecret == null) throw 'Invalid client secret from backend';

      // 2. Initialize Stripe Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Company',
          style: ThemeMode.light,
        ),
      );

      // 2. Present Payment Sheet UI
      await Stripe.instance.presentPaymentSheet();
 

      // 4. Payment successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful!')),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount (\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isProcessing ? null : _startPayment,
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> initStripe() async {
  // Set the Stripe publishable key
  Stripe.publishableKey = dotenv.env['STRIPE_KEY'] ?? '';
  // Optional settings for Apple Pay or redirects
  Stripe.merchantIdentifier = 'merchant.com.yourapp';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
}
