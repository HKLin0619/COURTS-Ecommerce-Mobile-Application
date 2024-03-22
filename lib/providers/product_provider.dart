import 'package:courts_ecommerce/models/product.dart';
import 'package:courts_ecommerce/services/product_service.dart';
import 'package:flutter/material.dart';


class ProductProvider with ChangeNotifier {

  final ProductService _productService = ProductService();
  late Product _currentProduct;
  Product get currentProduct => _currentProduct;

  Future<void> deleteProduct(String productID) async {
    try {
      await _productService.deleteProduct(productID);
      notifyListeners();
    } catch (error) {
      print('An unexpected error occurred: $error');
    }
  }

  Future<void> loadProductById(String productID) async {
    _currentProduct = await _productService.getProductById(productID);
    notifyListeners();
  }

}