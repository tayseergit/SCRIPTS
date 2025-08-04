import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeTestScreen extends StatefulWidget {
  const StripeTestScreen({Key? key}) : super(key: key);

  @override
  State<StripeTestScreen> createState() => _StripeTestScreenState();
}

class _StripeTestScreenState extends State<StripeTestScreen> {
  final _clientSecretController = TextEditingController();

  Future<void> _showPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'My App',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Payment successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stripe Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _clientSecretController,
              decoration: InputDecoration(labelText: 'Enter clientSecret'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showPaymentSheet(_clientSecretController.text),
              child: Text('Show Payment Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
