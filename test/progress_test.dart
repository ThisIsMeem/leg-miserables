import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/progress.dart';

void main() {
  group('progressPercent', () {
    test('returns 0 when goal is 0', () {
      expect(progressPercent(500, 0), 0);
    });

    test('returns 0 when goal is negative', () {
      expect(progressPercent(500, -100), 0);
    });

    test('returns 0 when steps is 0', () {
      expect(progressPercent(0, 10000), 0);
    });

    test('calculates a normal percentage', () {
      expect(progressPercent(2500, 10000), 25);
    });

    test('returns 100 when steps equal the goal', () {
      expect(progressPercent(10000, 10000), 100);
    });

    test('caps at 100 when steps exceed the goal', () {
      expect(progressPercent(15000, 10000), 100);
    });
  });
}
