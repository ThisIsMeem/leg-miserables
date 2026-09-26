import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:leg_miserables/databasehelper.dart';
import 'package:leg_miserables/historyitem.dart';

class HistoryGraph extends StatefulWidget {
  const HistoryGraph({super.key});

  @override
  State<HistoryGraph> createState() => _HistoryGraphState();
}

class _HistoryGraphState extends State<HistoryGraph> {
  late List<Map<String, dynamic>> historyMaps;
  
   @override
  void initState() {
    super.initState();
    initialize(); 
  }
  
  void initialize() async {
    historyMaps = await _fetchHistory();
  }
  
  Future<List<Map<String, dynamic>>> _fetchHistory() async {
    return await DatabaseHelper.instance.queryAllHistoryItems();
  }

  @override
  Widget build(BuildContext context) {
    //List<Map<String, dynamic>> historyMaps = await _fetchHistory();
    var history = historyMaps
        .map((historyMap) => HistoryItem.fromMap(historyMap))
        .toList();

    var chart = BarChart(
      BarChartData(
        barGroups: history.asMap().entries.map((entry) {
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
