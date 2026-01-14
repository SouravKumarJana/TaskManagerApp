class Task {
  final String title;
  bool completed;
  final DateTime dueTime;

  Task({
    required this.title,
    this.completed = false,
    required this.dueTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      completed: json['completed'],
      dueTime: DateTime.parse(json['dueTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'dueTime': dueTime.toIso8601String(),
    };
  }
}
