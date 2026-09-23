class HistoryItem{
  const HistoryItem({required this.date, this.steps = 0, this.goalReached = false});
  
  final DateTime date;
  final int steps;
  final bool goalReached;
}