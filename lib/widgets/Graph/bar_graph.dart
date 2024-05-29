import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'bar_chart_model.dart';

class MyBarGraph extends StatelessWidget {
  MyBarGraph({Key? key, required revnue}) : super(key: key);

  final List<BarChartModel> data = [
    BarChartModel(
      year: "2014",
      financial: [200, 250, 300], // Providing a list of financial values
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.green),
      ], // Providing a list of colors
    ),
    BarChartModel(
      year: "2015",
      financial: [300, 350, 400],
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.green),
      ],
    ),
    BarChartModel(
      year: "2016",
      financial: [100, 150, 200],
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.green),
      ],
    ),
    BarChartModel(
      year: "2017",
      financial: [400, 450, 500],
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.green),
      ],
    ),
    BarChartModel(
      year: "2018",
      financial: [600, 630, 660],
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.yellow),
      ],
    ),
    BarChartModel(
      year: "2019",
      financial: [900, 950, 1000],
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.green),
      ],
    ),
    BarChartModel(
      year: "2020",
      financial: [350, 400, 450],
      colors: [
        charts.ColorUtil.fromDartColor(Colors.blueGrey),
        charts.ColorUtil.fromDartColor(Colors.red),
        charts.ColorUtil.fromDartColor(Colors.green),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = data.map((item) {
      return charts.Series(
        id: item.year,
        data: item.financial.asMap().entries.map((entry) {
          return BarChartModel(
            year: item.year,
            financial: [entry.value],
            colors: [
              item.colors[entry.key]
            ], // Use the color corresponding to the financial value
          );
        }).toList(),
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) =>
            double.parse(series.financial[0].toString()),
        colorFn: (BarChartModel series, _) => series.colors[0],
      );
    }).toList();

    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: charts.BarChart(
            series,
            animate: true,
          ),
        ),
      ),
    );
  }
}
