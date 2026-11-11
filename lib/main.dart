import 'package:leg_miserables/databasehelper.dart';
import 'package:leg_miserables/historypage.dart';
import 'package:leg_miserables/widgets/step_display.dart';
import 'package:flutter/material.dart';
import 'package:leg_miserables/widgets/change_daily_goal.dart';
import 'package:leg_miserables/widgets/edit_goal_button.dart';
import 'package:leg_miserables/progress.dart';

import 'dart:async';

import 'package:pedometer/pedometer.dart';

import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await DatabaseHelper.instance.initDb();
  await DatabaseHelper.instance.initializeHistoryItems();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leg Miserables',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color(0xff00aa00),
          primary: const Color(0xff00aa00),
          surface: const Color(0xffefec6b),
          outline: const Color(0xff13462d),
          brightness: Brightness.light
          ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20, color: Colors.brown),
          titleLarge: TextStyle(fontSize: 30, color: Colors.black)
        )
      ),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color(0xff71731f),
          primary: const Color(0xff00aa00),
          surface: const Color(0xff13462d),
          outline: const Color(0xffe8e7ab),
          brightness: Brightness.dark
          ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20, color: Colors.yellow),
          titleLarge: TextStyle(fontSize: 30, color: Colors.white)
        )
      ),
      
      home: const MyHomePage(title: 'Leg Miserables'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _steps = 0;

  int _dailyGoal = 10000;

  // The live connection to the phone's step sensor.
  late Stream<StepCount> _stepCountStream;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  // Connects to the phone's pedometer and listens for step updates.
  void _startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onError);
  }

  // Called each time the sensor reports a new step count.
  // Called each time the sensor reports a new step count.
  void _onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  // Called if the sensor can't be read.
  // Called if the sensor can't be read.
  void _onError(error) {
    setState(() {
      _steps = 0;
    });
  }

  Future<void> _editGoal() async {
    final newGoal = await showChangeGoalDialog(context);
    if (newGoal == null || !mounted) return; // user cancelled
    setState(() => _dailyGoal = newGoal);
  }

  int howManySteps() {
    return _steps;
  }

  bool isGoalReached() {
    return _steps >= _dailyGoal;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the __addTestSteps method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Leg Miserables", style: Theme.of(context).textTheme.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Builder(
                builder: (context) {
                  final now = DateTime.now();
                  return Text('${now.month}/${now.day}', style: Theme.of(context).textTheme.bodyMedium,);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StepDisplay(
              steps: _steps,
              goal: _dailyGoal,
              progressPercent: progressPercent(_steps, _dailyGoal),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HistoryPageScreen(title: 'My History'),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('My History', style: Theme.of(context).textTheme.bodyMedium), Icon(Icons.chevron_right)],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: EditGoalButton(onPressed: _editGoal),
    );
  }
}
