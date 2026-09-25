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

  final int steps; // how many steps to show
  final int goal; // the daily goal to show
  final double progressPercent; // the progress % calculated by the parent

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Steps box + Goal box, side by side (wireframe Page #1 top row)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: _Box(
                child: Center(
                  child: Text(
                    '$steps steps',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _Box(
                child: Center(
                  child: Text(
                    'Goal: $goal',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // "Visual representation of total/goal steps" box
        _Box(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: CircularProgressIndicator(
                  value: progressPercent.clamp(0, 100) / 100,
                  strokeWidth: 10,
                ),
              ),
              const SizedBox(height: 12),
              Text('Progress: ${progressPercent.toStringAsFixed(0)}%'),
            ],
          ),
        ),
      ],
    );
  }
}

// Shared box styling for the sketched-border look from the wireframe.
class _Box extends StatelessWidget {
  const _Box({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}
