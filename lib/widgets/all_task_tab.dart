import 'package:flutter/material.dart';
import '../model/task.dart';

class AllTasksTab extends StatelessWidget {
  final List<Task> tasks;

  const AllTasksTab({super.key, required this.tasks});

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
            onChanged: null, // read-only
          ),
        );
      },
    );
  }
}
