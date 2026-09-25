//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leg_miserables/databasehelper.dart';
import 'package:leg_miserables/historyitem.dart';
import 'package:leg_miserables/main.dart';
import 'package:leg_miserables/widgets/history_graph.dart';

//void main() async{}

class HistoryPageScreen extends StatefulWidget{
  HistoryPageScreen({
      super.key,
      required this.title,
      //required this.userHistory,
  });
  final String title;
  final DateTime today = DateTime.now();
  //final List<HistoryItem> userHistory;
  

  String get getTodaysDate => ("${today.month}/${today.day}");

  @override
  State<HistoryPageScreen> createState() => _HistoryPageScreenState();
}

class _HistoryPageScreenState extends State<HistoryPageScreen>{
  List<HistoryItem> _history = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final historyMaps = await DatabaseHelper.instance.queryAllHistoryItems();
    setState(() {
      _history = historyMaps.map((historyMap) => HistoryItem.fromMap(historyMap)).toList();
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: Text(widget.getTodaysDate),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            HistoryGraph(),
            ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_history[index].getDate()),
                  subtitle: Text(_history[index].getSteps()),
                  trailing: (_history[index].wasGoalReached())?Icon(Icons.star):Icon(Icons.star_border_outlined),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Leg Miserables'),
                  ),
                );
              },
              child: const Text('My History'),
            ),
          ],
        ),
      ),
    );
  }
}
/*List<HistoryItem> getHistory(){
  List<HistoryItem> history;

  historyItems();
  return history;
}*/