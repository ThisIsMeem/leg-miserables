class HistoryItem {
  const HistoryItem({
    required this.date,
    this.steps = 0,
    this.goalReached = false,
  });

  final DateTime date;
  final int steps;
  final bool goalReached;

  Map<String, Object?> toMap() {
    return {
      'date': date.toIso8601String(),
      'steps': steps,
      'goalReached': goalReached ? 1 : 0,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      date: DateTime.parse(map['date'] as String),
      steps: map['steps'] as int,
      goalReached: (map['goalReached'] as int) == 1,
    );
  }

  @override
  String toString() {
    return 'HistoryItem{date: $date, steps: $steps, goalReached: $goalReached}';
  }

  String getSteps() {
    return steps.toString();
  }

  bool wasGoalReached() {
    return goalReached;
  }

  String getDate() {
    int day = date.day;
    int month = date.month;
    return "$month/$day";
  }
}
