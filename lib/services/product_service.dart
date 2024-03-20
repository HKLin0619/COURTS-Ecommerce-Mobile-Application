import 'package:courts_ecommerce/models/product.dart';
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
}
