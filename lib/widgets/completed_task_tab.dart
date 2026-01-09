import 'package:flutter/material.dart';
import '../model/task.dart';

class CompletedTasksTab extends StatelessWidget {
  final List<Task> tasks;

  const CompletedTasksTab({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks =
        tasks.where((task) => task.completed).toList();

    if (completedTasks.isEmpty) {
      return const Center(child: Text('No completed tasks'));
    }

    return ListView.builder(
      itemCount: completedTasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.green),
          title: Text(completedTasks[index].title),
        );
      },
    );
  }
}
