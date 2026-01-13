import 'package:flutter/material.dart';
import '../model/task.dart';
import '../service/task_storage_service.dart';

class TaskController extends ChangeNotifier {
  final TaskStorageService storageService;

  TaskController(this.storageService);

  List<Task> tasks = [];
  bool isLoading = true;

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();

    tasks = await storageService.loadTasks();
    isLoading = false;
    notifyListeners();
  }

  void addTask(String title, DateTime dateTime) {
    tasks.add(
      Task(
        title: title,
        createdAt: dateTime,
      ),
    );

    storageService.saveTasks(tasks);
    notifyListeners();
  }

  void toggleTask(int index, bool value) {
    tasks[index].completed = value;
    storageService.saveTasks(tasks);
    notifyListeners();
  }
}
