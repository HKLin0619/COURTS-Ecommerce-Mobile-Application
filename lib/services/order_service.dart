import 'package:courts_ecommerce/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderService {
  var url = '${dotenv.env['URL']}';

  Future<bool> addOrder({
    required orderDate,
    required orderAmount,
    required userID,
    required productID,
  }) async {
    try {
      final response = await http.post(Uri.parse('$url/addOrder.php'), body: {
        'orderDate': orderDate,
        'orderAmount': orderAmount,
        'userID': userID,
        'productID': productID,
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return true;
        } else if (jsonData['status'] == 'emptyInput') {
          Fluttertoast.showToast(
            msg: 'Please fill in the information !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );
          throw Exception('Failed to add order: Empty input');
        } else if (jsonData['status'] == 'unsuccess') {
          Fluttertoast.showToast(
            msg: 'Non-compliant Product Information !',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );
          throw Exception('Failed to add product: Unsuccess');
        } else {
          throw Exception('Unexpected status: ${jsonData['status']}');
        }
      } else {
        throw Exception('Failed to add order');
      }
    } catch (error) {
      throw Exception('An unexpected error occurred: $error');
    }
  }
}
