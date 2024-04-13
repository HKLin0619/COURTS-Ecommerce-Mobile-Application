import 'package:courts_ecommerce/models/monthlySalesData.dart';
import 'package:courts_ecommerce/models/product.dart';
import 'package:courts_ecommerce/models/yearlySalesData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalysisService {

  var url = '${dotenv.env['URL']}';

  Future<List<Yearly>> yearlyData() async {
    final response = await http.get(
        Uri.parse('$url/yearlyAnalysis.php')
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Yearly> yearlyData = [];
      for (var item in jsonData) {
        yearlyData.add(Yearly(
            year: item['year'],
            totalSales: int.parse(item['count']),
        ));
      }
      return yearlyData;
    } else {
      throw Exception('Unexpected error occured !');
    }
  }

  Future<List<Monthly>> monthlyData() async {
    final response = await http.get(
        Uri.parse('$url/monthlyAnalysis.php')
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Monthly> monthlyData = [];
      for (var item in jsonData) {
        monthlyData.add(Monthly(
          month: item['month'],
          totalSales: int.parse(item['count']),
        ));
      }
      return monthlyData;
    } else {
      throw Exception('Unexpected error occured !');
    }
  }

}


