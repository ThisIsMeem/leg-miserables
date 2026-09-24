// Calculates progress toward the daily goal as a percentage (0–100).
// Returns 0 if the goal is 0 or less, to avoid dividing by zero.
// Capped at 100
double progressPercent(int steps, int goal) {
  if (goal <= 0) return 0;               // guard: no divide-by-zero
  double percent = (steps / goal) * 100; // the core math
  if (percent > 100) percent = 100;      // cap at 100%
  return percent;
}