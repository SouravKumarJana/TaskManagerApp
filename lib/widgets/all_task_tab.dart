import 'package:flutter/material.dart';
import '../model/task.dart';

class AllTasksTab extends StatelessWidget {
  final List<Task> tasks;
  final Function(int, bool) onToggle;

  const AllTasksTab({
    super.key,
    required this.tasks,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.completed,
            onChanged: (value) {
              if (value != null) {
                onToggle(index, value);
              }
            },
          ),
        );
      },
    );
  }
}
