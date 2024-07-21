class Task {
  final String id;
  final String title;
  final String description;
  final String assignee;
  final DateTime dueDate;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.dueDate,
    required this.status,
  });
}
