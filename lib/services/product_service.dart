import 'package:courts_ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {

  Future<List<Product>> fetchData() async {

    final response = await http.get(

        Uri.parse('http://192.168.0.33/bit311Assignment/listProduct.php')

    );

      if (response.statusCode == 200) {

        final jsonData = json.decode(response.body);

        List<Product> productList = [];
        for (var item in jsonData) {
          productList.add(Product(
            productID: item['productID'],
            productName: item['productName'],
            productPrice: double.parse(item['productPrice']),
            productDescription: item['productDescription'],
            productImgVideo: item['productImgVideo'],
            productCategory: item['productCategory'],
            productLocation: item['productLocation'],
          ));
        }

        return productList;

    } else {

      throw Exception('Unexpected error occured !');

    }
  }

  Future<bool> addProduct({
    required TextEditingController productNameController,
    required TextEditingController productPriceController,
    required TextEditingController productCategoryController,
    required TextEditingController productDescriptionController,
    required TextEditingController productLocationController,
    required TextEditingController productImgVideoController,
  }) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.0.33/bit311Assignment/addProduct.php'),
          body:{
            'productName': productNameController.text,
            'productPrice': productPriceController.text,
            'productCategory': productCategoryController.text,
            'productDescription': productDescriptionController.text,
            'productLocation': productLocationController.text,
            'productImgVideo': productImgVideoController.text,
          }
      );

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

          throw Exception('Failed to add product: Empty input');

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

        throw Exception('Failed to add product');

      }

    } catch (error) {

      throw Exception('An unexpected error occurred: $error');

    }

  }

}
