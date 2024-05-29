import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String year;
  List<int> financial;
  List<charts.Color> colors;

  BarChartModel({
    required this.year,
    required this.financial,
    required this.colors,
  });
}
