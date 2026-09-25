import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/widgets/edit_goal_button.dart';

void main() {
  group('EditGoalButton', () {
    testWidgets('shows a pencil icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EditGoalButton(onPressed: () {})),
        ),
      );

      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    });

    testWidgets('tapping it calls onPressed', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EditGoalButton(onPressed: () => tapped = true)),
        ),
      );

      await tester.tap(find.byType(EditGoalButton));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
