import 'package:flutter/material.dart';
import '../service/task_service.dart';
import '../network/dio_client.dart';
import '../model/task.dart';
import 'all_task_tab.dart';
import 'completed_task_tab.dart';
import 'stats_tab.dart';
import 'bar_stack.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TaskService taskService;

  bool isLoading = true;
  String? errorMessage;
  List<Task> tasks = [];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    taskService = TaskService(DioClient());
    loadTasks();
  }

  Future<void> loadTasks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await taskService.fetchTasks();
      setState(() {
        tasks = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading tasks';
        isLoading = false;
      });
    }
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void toggleTask(int index, bool value) {
  setState(() {
    tasks[index].completed = value;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),

      body: _buildBody(),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(6),
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 15),
          ],
        ),
        child: BarStack(onIndexChanged: onTabChanged),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }
  
    return IndexedStack(
      index: currentIndex,
      children: [
        AllTasksTab(tasks: tasks, onToggle: toggleTask),
        CompletedTasksTab(tasks: tasks),
        StatsTab(tasks: tasks),
      ],
    );
  }
}
