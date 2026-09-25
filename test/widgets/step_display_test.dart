import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/widgets/step_display.dart';

void main() {
  Future<void> pumpStepDisplay(
    WidgetTester tester, {
    required int steps,
    required int goal,
    required double progressPercent,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StepDisplay(
            steps: steps,
            goal: goal,
            progressPercent: progressPercent,
          ),
        ),
      ),
    );
  }

  group('StepDisplay', () {
    testWidgets('shows the step count', (tester) async {
      await pumpStepDisplay(
        tester,
        steps: 4200,
        goal: 10000,
        progressPercent: 42,
      );

      expect(find.text('4200 steps'), findsOneWidget);
    });

    testWidgets('shows the goal', (tester) async {
      await pumpStepDisplay(
        tester,
        steps: 4200,
        goal: 10000,
        progressPercent: 42,
      );

      expect(find.text('Goal: 10000'), findsOneWidget);
    });

    testWidgets('shows progress rounded to a whole percent', (tester) async {
      await pumpStepDisplay(
        tester,
        steps: 1234,
        goal: 10000,
        progressPercent: 12.34,
      );

      expect(find.text('Progress: 12%'), findsOneWidget);
    });

    testWidgets('shows 0 steps and 0% correctly', (tester) async {
      await pumpStepDisplay(tester, steps: 0, goal: 10000, progressPercent: 0);

      expect(find.text('0 steps'), findsOneWidget);
      expect(find.text('Progress: 0%'), findsOneWidget);
    });

    testWidgets('shows 100% when progress is capped', (tester) async {
      await pumpStepDisplay(
        tester,
        steps: 15000,
        goal: 10000,
        progressPercent: 100,
      );

      expect(find.text('Progress: 100%'), findsOneWidget);
    });
  });
}
