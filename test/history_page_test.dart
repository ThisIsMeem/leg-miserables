import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/historypage.dart';

void main() {
  group('HistoryPageScreen', () {
    testWidgets('shows the given title in the app bar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: HistoryPageScreen(title: 'My History')),
      );

      expect(find.text('My History'), findsOneWidget);
    });

    testWidgets("shows today's date as month/day", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: HistoryPageScreen(title: 'My History')),
      );

      final now = DateTime.now();
      expect(find.text('${now.month}/${now.day}'), findsOneWidget);
    });
  });
}
