//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leg_miserables/main.dart';
import 'package:leg_miserables/widgets/history_graph.dart';

class HistoryPageScreen extends StatefulWidget{
  HistoryPageScreen({
      super.key,
      required this.title,
  });
  final String title;
  final DateTime today = DateTime.now();
  

  String get getTodaysDate => ("${today.month}/${today.day}");

  @override
  State<HistoryPageScreen> createState() => _HistoryPageScreenState();
}

class _HistoryPageScreenState extends State<HistoryPageScreen>{
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
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
            ListView(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'placeholder'),
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

