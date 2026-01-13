import 'package:flutter/material.dart';
import '../controller/task_controller.dart';
import '../service/task_storage_service.dart';
import 'all_task_tab.dart';
import 'completed_task_tab.dart';
import 'stats_tab.dart';
import 'add_task_tab.dart';
import 'bar_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TaskController(TaskStorageService());
    controller.loadTasks();
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTabChanged(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),

      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : IndexedStack(
              index: currentIndex,
              children: [
              AllTasksTab(
              tasks: controller.tasks,
              onToggle: controller.toggleTask,
              ),
              AddTaskTab(onAdd: controller.addTask), // 📅 Date & time picker HERE
              CompletedTasksTab(tasks: controller.tasks),
              StatsTab(tasks: controller.tasks),
              ],
          ),


      bottomNavigationBar: BarStack(onIndexChanged: onTabChanged),
    );
  }
}
