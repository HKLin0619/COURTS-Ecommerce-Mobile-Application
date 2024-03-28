import 'package:charts_flutter/flutter.dart' as charts;

class Yearly {
  final String year;
  final int totalSales;
  final charts.Color barColor;

  Yearly(
      {
        required this.year,
        required this.totalSales,
        required this.barColor
      }
  );
}


