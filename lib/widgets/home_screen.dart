import 'package:flutter/material.dart';
import '../controller/task_controller.dart';
import '../controller/connectivity_controller.dart';
import '../service/task_storage_service.dart';
import '../service/connectivity_service.dart';

import 'all_task_tab.dart';
import 'completed_task_tab.dart';
import 'stats_tab.dart';
import 'add_task_tab.dart';
import 'bar_stack.dart';
import 'connectivity_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskController taskController;
  late ConnectivityController connectivityController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    taskController = TaskController(TaskStorageService());
    taskController.loadTasks();
    taskController.addListener(() => setState(() {}));

    connectivityController =
        ConnectivityController(ConnectivityService());

    connectivityController.addListener(_showConnectivitySnackBar);
  }

  void _showConnectivitySnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (connectivityController.isOffline) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
            backgroundColor: Colors.red,
          ),
        );
      } else if (connectivityController.restored) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Back online"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    taskController.dispose();
    connectivityController.dispose();
    super.dispose();
  }

  void onTabChanged(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedBuilder(
              animation: connectivityController,
              builder: (_, __) {
                if (connectivityController.isWifi) {
                  return const Icon(Icons.wifi, color: Colors.green);
                } else if (connectivityController.isMobile) {
                  return const Icon(Icons.signal_cellular_4_bar,
                      color: Colors.green);
                } else {
                  return const Icon(Icons.wifi_off, color: Colors.red);
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ConnectivityBanner(controller: connectivityController),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                AllTasksTab(
                  tasks: taskController.tasks,
                  onToggle: taskController.toggleTask,
                ),
                AddTaskTab(onAdd: taskController.addTask),
                CompletedTasksTab(tasks: taskController.tasks),
                StatsTab(tasks: taskController.tasks),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarStack(onIndexChanged: onTabChanged),
    );
  }
}
