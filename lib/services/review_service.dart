import 'package:courts_ecommerce/models/review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  var url = '${dotenv.env['URL']}';

  Future<bool> addReview({
    required int orderID,
    required int productID,
    required String comment,
    required int rating,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$url/addReview.php'),
        body: {
          'orderID': orderID.toString(),
          'productID': productID.toString(),
          'comment': comment,
          'rating': rating.toString(),
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          Fluttertoast.showToast(
            msg: 'Review added successfully!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 12.0,
          );
          return true;
        } else if (jsonData['status'] == 'emptyInput') {
          Fluttertoast.showToast(
            msg: 'Please fill in all fields!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );
          throw Exception('Failed to add review: Empty input');
        } else if (jsonData['status'] == 'unsuccess') {
          Fluttertoast.showToast(
            msg: 'Failed to add review. Please try again.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
            fontSize: 12.0,
          );
          throw Exception('Failed to add review: Unsuccessful');
        } else {
          throw Exception('Unexpected status: ${jsonData['status']}');
        }
      } else {
        throw Exception('Failed to add review. Server error.');
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 12.0,
      );
      throw Exception('An unexpected error occurred: $error');
    }
  }
}
