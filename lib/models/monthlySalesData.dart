import 'package:charts_flutter/flutter.dart' as charts;

class Monthly {
  final String monthly;
  final int totalSales;
  final charts.Color barColor;

  Monthly(
      {
        required this.monthly,
        required this.totalSales,
        required this.barColor
      }
  );
}


