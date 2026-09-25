import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/historyitem.dart';

void main() {
  group('HistoryItem', () {
    test('stores the date, steps, and goalReached it is given', () {
      final date = DateTime(2026, 9, 24);
      final item = HistoryItem(date: date, steps: 8500, goalReached: true);

      expect(item.date, date);
      expect(item.steps, 8500);
      expect(item.goalReached, isTrue);
    });

    test('defaults steps to 0 when not provided', () {
      final item = HistoryItem(date: DateTime(2026, 9, 24));

      expect(item.steps, 0);
    });

    test('defaults goalReached to false when not provided', () {
      final item = HistoryItem(date: DateTime(2026, 9, 24));

      expect(item.goalReached, isFalse);
    });
  });
}
