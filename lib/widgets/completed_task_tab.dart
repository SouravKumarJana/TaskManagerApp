import 'package:flutter/material.dart';
import '../model/task.dart';

class CompletedTasksTab extends StatelessWidget {
  final List<Task> tasks;

  const CompletedTasksTab({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((t) => t.completed).toList();

    if (completed.isEmpty) {
      return const Center(child: Text('No completed tasks'));
    }

    return ListView.builder(
      itemCount: completed.length,
      itemBuilder: (context, index) {
        final task = completed[index];
        return ListTile(title: Text(task.title));
      },
    );
  }
}
