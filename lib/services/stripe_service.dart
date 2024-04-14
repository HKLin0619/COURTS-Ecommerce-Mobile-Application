import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  Map<String, dynamic>? paymentIntent;

  static const String secret =
      "sk_test_51OD60zLeBMspac8v5EFucHIYPvCwmfk7qev2Qio7VvB4j7cS1cTZFbyWR2ApiiHXJ7d02rWsW9OUJmlYQ4azcIrs007KoeOqPn";
  Future<void> stripeMakePayment(amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'MYR');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Course App',
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'MY',
            testEnv: true,
          ),
        ),
      );

      //STEP 3: Display Payment sheet
      // displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      // Fluttertoast.showToast(msg: 'Payment succesfully completed');
      print("Payment succesfully completed");
    } on Exception catch (e) {
      if (e is StripeException) {
        // Fluttertoast.showToast(
        // msg: 'Error from Stripe: ${e.error.localizedMessage}');
        print(e.error.localizedMessage);
      } else {
        // Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
        print(e);
      }
    }
  }

  //create Payment
  createPaymentIntent(double amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': (amount * 100).toInt().toString(),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${secret}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
