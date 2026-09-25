import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:leg_miserables/historyitem.dart';

class HistoryGraph extends StatelessWidget {
  const HistoryGraph({super.key});

  @override
  Widget build(BuildContext context) {
    var pastWeek = [
      // PLACEHOLDER DATA
      HistoryItem(date: DateTime.now()),
    ];

    var chart = BarChart(
      BarChartData(
        barGroups: pastWeek.asMap().entries.map((entry) {
          int index = entry.key;
          HistoryItem weekData = entry.value;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(toY: weekData.steps.toDouble(), width: 20),
            ],
          );
        }).toList(),
      ),
    );

    var chartWidget = Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(height: 200.0, child: chart),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[chartWidget],
        ),
      ),
    );
  }
}
