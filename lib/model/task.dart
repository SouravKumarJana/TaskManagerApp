class Task {
  final String title;
  bool completed;
  final DateTime dueTime;
  bool notified; 

  Task({
    required this.title,
    required this.dueTime,
    this.completed = false,
    this.notified = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      completed: json['completed'],
      dueTime: DateTime.parse(json['dueTime']),
      notified: json['notified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'dueTime': dueTime.toIso8601String(),
      'notified': notified,
    };
  }
}
