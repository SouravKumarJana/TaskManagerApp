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

  // String formatDate(DateTime d) =>
  //     '${d.day}/${d.month}/${d.year} '
  //     '${d.hour}:${d.minute.toString().padLeft(2, '0')}';
  String formatDate(DateTime d) {
  final hour = d.hour > 12 ? d.hour - 12 : d.hour == 0 ? 12 : d.hour;
  final amPm = d.hour >= 12 ? 'PM' : 'AM';
  return '${d.day}/${d.month}/${d.year} '
         '$hour:${d.minute.toString().padLeft(2, '0')} $amPm';
}


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
          subtitle: Text(formatDate(task.dueTime)),
          value: task.completed,
          onChanged: (value) {
            if (value == true && DateTime.now().isBefore(task.dueTime)) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Not Allowed'),
                  content: const Text(
                    'You cannot complete this task before its due time.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                ),
              );
              return;
            }

            onToggle(index, value ?? false);
          },
        );

      },
    );
  }
}
