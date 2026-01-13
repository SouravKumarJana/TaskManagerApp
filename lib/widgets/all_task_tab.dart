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

  String formatDate(DateTime d) =>
      '${d.day}/${d.month}/${d.year} '
      '${d.hour}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks added'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return CheckboxListTile(
          title: Text(task.title),
          subtitle: Text(formatDate(task.createdAt)),
          value: task.completed,
          onChanged: (v) => onToggle(index, v ?? false),
        );
      },
    );
  }
}
