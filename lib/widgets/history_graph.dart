import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:leg_miserables/historyitem.dart';

class HistoryGraph extends StatelessWidget {
  const HistoryGraph({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var pastWeek = [
      //PLACEHOLDER DATA
      HistoryItem(date: DateTime.now()),
    ];
    var series = [
      charts.Series(
        id: 'Steps',
        domainFn: (HistoryItem weekData, _) => weekData.date,
        measureFn: (HistoryItem weekData, _) => weekData.steps,
        //colorFn: (HistoryItem weekData, _) => weekData.goalReached,
        data: pastWeek,
      ),
    ];

    var chart = new charts.BarChart(
      series.cast<charts.Series<dynamic, String>>(),
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );
    
    return Scaffold(
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            chartWidget,
            ],
        ),
      )
    );

    //throw UnimplementedError();
  }
  
}

