import 'package:flutter_test/flutter_test.dart';
import 'package:leg_miserables/progress.dart';

void main() {
  // Tests for progressPercent, the function that calculates how close
  // the user's steps are to their daily goal. This is a critical piece
  // of Page 1, so we check its normal case and its two edge cases.

  test('returns 50% when steps are half the goal', () {
    // 5000 steps toward a 10000 goal should be exactly 50%.
    expect(progressPercent(5000, 10000), 50);
  });

  test('caps at 100% when steps exceed the goal', () {
    // 20000 steps on a 10000 goal would be 200%, but we cap it at 100
    // so the progress bar never overfills.
    expect(progressPercent(20000, 10000), 100);
  });

  test('returns 0 when the goal is 0 to avoid dividing by zero', () {
    // Dividing by zero would crash, so a goal of 0 safely returns 0.
    expect(progressPercent(5000, 0), 0);
  });
}