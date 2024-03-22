import 'package:courts_ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {

  var url = '${dotenv.env['URL']}';

  Future<List<Product>> fetchData() async {
    final response = await http.get(
        Uri.parse('$url/listProduct.php')
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
          Uri.parse('$url/addProduct.php'),
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

  Future<void> deleteProduct(String productID) async  {
    try {
      final response = await http.post(
          Uri.parse('$url/deleteProduct.php'),
          body:{'productID': productID},
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          Fluttertoast.showToast(
              msg: 'Delete successfully!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 12.0,
          );
          throw Exception('Success to delete product');
        }  else {
          throw Exception('Unexpected status: ${jsonData['status']}');
        }
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (error) {
      throw Exception('An unexpected error occurred: $error');
    }
  }

  Future<Product> getProductById(String productID) async {
    final response = await http.post(
      Uri.parse('$url/getProductById.php'),
      body: {'productID': productID},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final productData = jsonData['data'];
      return Product(
        productID: productData['productID'],
        productName: productData['productName'],
        productPrice: productData['productPrice'],
        productDescription: productData['productDescription'],
        productImgVideo: productData['productImgVideo'],
        productCategory: productData['productCategory'],
        productLocation: productData['productLocation'],
      );
    } else {
      throw Exception('Product Not Found');
    }
  }

}


