import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> payWithStripePaymentSheet(String clientSecret) async {
  try {
    // 1. تهيئة شاشة الدفع مع clientSecret من backend
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Your App Name',
      ),
    );

    // 2. عرض شاشة الدفع الافتراضية
    await Stripe.instance.presentPaymentSheet();

    print('✅ الدفع تم بنجاح');
  } catch (e) {
    print('❌ حدث خطأ: $e');
  }
}
