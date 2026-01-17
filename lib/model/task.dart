class Task {
  final int id;                 
  final String title;
  final DateTime dueTime;       
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.dueTime,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'dueTime': dueTime.toIso8601String(),
        'completed': completed,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        dueTime: DateTime.parse(json['dueTime']),
        completed: json['completed'],
      );
}
