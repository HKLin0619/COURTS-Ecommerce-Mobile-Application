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
          throw Exception('Unexpected status: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to add order');
      }
    } catch (error) {
      throw Exception('An unexpected error occurred: $error');
    }
  }

  Future<Map<String, dynamic>> getOrderForm(String orderID) async {
    try {
      final response =
          await http.get(Uri.parse('$url/getOrderForm.php?orderID=$orderID'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData.containsKey('productID') &&
            jsonData.containsKey('userID') &&
            jsonData.containsKey('productName')) {
          return {
            'productID': jsonData['productID'],
            'userID': jsonData['userID'],
            'productName': jsonData['productName'],
          };
        } else {
          throw Exception('Incomplete product details received');
        }
      } else {
        throw Exception(
            'Failed to fetch product details: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'An unexpected error occurred while fetching product details: $error');
    }
  }

  // get list of orders by user id
  Future<List<Order>> fetchData(String userId) async {
    final response =
        await http.get(Uri.parse('$url/listOrder.php?userID=$userId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Order> orderList = [];
      for (var item in jsonData) {
        orderList.add(Order(
            orderId: item['orderId'],
            orderDate: item['orderDate'],
            orderAmount: double.parse(item['orderAmount']),
            productImageUrl: item['productImgVideo']));
      }
      return orderList;
    } else {
      throw Exception('User ID missing');
    }
  }
}
