
class HistoryItem{
  const HistoryItem({required this.date, this.steps = 0, this.goalReached = false});
  
  final DateTime date;
  final int steps;
  final bool goalReached;

  Map<String, Object?> toMap() {
    return {'date': date, 'steps': steps, 'goalReached': goalReached};
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      date: map['date'],
      steps: map['steps'],
      goalReached: map['goalReached'],
    );
  }

  @override
  String toString() {
    return 'HistoryItem{date: $date, steps: $steps, goalReached: $goalReached}';
  }

  String getSteps(){
    return steps.toString();
  }

  bool wasGoalReached(){
    return goalReached;
  }

  String getDate(){
    int day = date.day;
    int month = date.month;
    return "$month/$day";
  }
}