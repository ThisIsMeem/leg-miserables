import 'package:flutter/material.dart';

// A stateless widget that just DISPLAYS the step info it's given.
// It holds no state of its own — it only shows the numbers passed in,
// and rebuilds when the parent hands it new ones.
class StepDisplay extends StatelessWidget {
  const StepDisplay({
    super.key,
    required this.steps,
    required this.goal,
    required this.progressPercent,
  });

  final int steps;              // how many steps to show
  final int goal;               // the daily goal to show
  final double progressPercent; // the progress % calculated by the parent

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$steps steps',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text('Goal: $goal'),
        Text('Progress: ${progressPercent.toStringAsFixed(0)}%'),
      ],
    );
  }
}