import 'dart:convert';

import 'package:courts_ecommerce/models/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OrderService {
  var url = '${dotenv.env['URL']}';

  Future<List<Order>> orderData() async {
    final response = await http.get(
        Uri.parse('$url/listOrder.php')
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Order> orderList = [];
      for (var item in jsonData) {
        orderList.add(Order(
            orderId: item['orderID'],
            orderDate: item['orderDate'],
            productPrice: double.parse(item['productPrice']),
            productName: item['productName'],
            productImgVideo: item['productImgVideo'],
            fullName: item['fullName'],
            phoneNumber: item['phoneNumber'],
            homeAddress: item['homeAddress'],
        ));
      }
      return orderList;
    } else {
      throw Exception('Unexpected error occured !');
    }
  }

}