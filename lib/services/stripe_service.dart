// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class StripeService {
//   // String secret = "sk_test_51OD60zLeBMspac8v5EFucHIYPvCwmfk7qev2Qio7VvB4j7cS1cTZFbyWR2ApiiHXJ7d02rWsW9OUJmlYQ4azcIrs007KoeOqPn";
//   static final String pubkey =
//       "pk_test_51OD60zLeBMspac8vhCyZvZbwsaNYryZXygbJYEiutm1IwWtA9fGjKSsYI15WQrnKPKdaEUGvw8zk92Z4dj7PqRro00KvT2OjaK";

//   static init() {
//     var stripe = Stripe.publishableKey = pubkey;
//     return stripe;
//   }

//   Future<dynamic> createCheckoutSession(
//       List<dynamic> items, double amount) async {
//     Stripe.publishableKey = pubkey;
//     return '1';
//   }
// }
