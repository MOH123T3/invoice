import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Define data structure for a bar group
class DataItem {
  int x;
  double y1;
  double y2;
  double y3;
  DataItem(
      {required this.x, required this.y1, required this.y2, required this.y3});
}

class Chart extends StatelessWidget {
  Chart({super.key});
  // Generate dummy data to feed the chart
  final List<DataItem> _myData = List.generate(
      30,
      (index) => DataItem(
            x: index,
            y1: Random().nextInt(20) + Random().nextDouble(),
            y2: Random().nextInt(20) + Random().nextDouble(),
            y3: Random().nextInt(20) + Random().nextDouble(),
          ));
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        backgroundColor: Colors.white70,
        borderData: FlBorderData(
            border: const Border(
          top: BorderSide.none,
          right: BorderSide.none,
          left: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        )),
        groupsSpace: 0,
        barGroups: [
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(fromY: 0, toY: 10, width: 5, color: Colors.amber),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(fromY: 0, toY: 10, width: 5, color: Colors.green),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(fromY: 0, toY: 15, width: 5, color: Colors.blue),
          ]),
          BarChartGroupData(x: 4, barRods: [
            BarChartRodData(fromY: 0, toY: 5, width: 5, color: Colors.orange),
          ]),
          BarChartGroupData(x: 8, barRods: [
            BarChartRodData(fromY: 0, toY: 7, width: 5, color: Colors.red),
          ]),
        ]));
  }
}
