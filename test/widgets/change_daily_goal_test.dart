import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/widgets/change_daily_goal.dart';

void main() {
  Future<void> pumpDialog(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => showChangeGoalDialog(context),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  group('ChangeGoalDialog', () {
    testWidgets('shows title, input field, and both buttons', (tester) async {
      await pumpDialog(tester);

      expect(find.text('Change Goal'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Cancel'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'OK'), findsOneWidget);
    });

    testWidgets('Cancel closes the dialog and returns null', (tester) async {
      int? result = -1; // sentinel so we can tell the callback ran
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    result = await showChangeGoalDialog(context);
                  },
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(ChangeGoalDialog), findsNothing);
      expect(result, isNull);
    });

    testWidgets('entering a valid number and tapping OK returns it', (
      tester,
    ) async {
      int? result = -1;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    result = await showChangeGoalDialog(context);
                  },
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '8000');
      await tester.tap(find.widgetWithText(OutlinedButton, 'OK'));
      await tester.pumpAndSettle();

      expect(find.byType(ChangeGoalDialog), findsNothing);
      expect(result, 8000);
    });

    testWidgets('empty input shows an error and keeps the dialog open', (
      tester,
    ) async {
      await pumpDialog(tester);

      await tester.tap(find.widgetWithText(OutlinedButton, 'OK'));
      await tester.pump();

      expect(find.text('Enter a number greater than 0'), findsOneWidget);
      expect(find.byType(ChangeGoalDialog), findsOneWidget);
    });

    testWidgets('zero shows the same error', (tester) async {
      await pumpDialog(tester);

      await tester.enterText(find.byType(TextField), '0');
      await tester.tap(find.widgetWithText(OutlinedButton, 'OK'));
      await tester.pump();

      expect(find.text('Enter a number greater than 0'), findsOneWidget);
    });
  });
}
