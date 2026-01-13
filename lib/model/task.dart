class Task {
  final String title;
  bool completed;
  final DateTime createdAt;

  Task({
    required this.title,
    this.completed = false,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      completed: json['completed'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
