class TaskItem {
  TaskItem({
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  final String title;
  final DateTime date;
  bool isCompleted;
}
