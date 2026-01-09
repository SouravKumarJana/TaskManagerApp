import 'package:flutter/material.dart';
import '../model/task.dart';
import 'stat_tile.dart';

class StatsTab extends StatelessWidget {
  final List<Task> tasks;

  const StatsTab({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    final completed = tasks.where((t) => t.completed).length;
    final pending = total - completed;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatTile(label: 'Total Tasks', value: total),
          StatTile(label: 'Completed Tasks', value: completed),
          StatTile(label: 'Pending Tasks', value: pending),
        ],
      ),
    );
  }
}

