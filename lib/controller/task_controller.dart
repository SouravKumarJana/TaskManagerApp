import 'package:flutter/material.dart';
import '../model/task.dart';
import '../service/task_storage_service.dart';
import '../service/local_notification_service.dart';

class TaskController extends ChangeNotifier {
  final TaskStorageService storage;
  List<Task> tasks = [];
  bool isLoading = true;

  TaskController(this.storage);

  Future<void> loadTasks() async {
    tasks = await storage.loadTasks();
    isLoading = false;
    notifyListeners();
  }

  void addTask(String title, DateTime dueTime) {
    if (dueTime.isBefore(DateTime.now())) return;

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      dueTime: dueTime,
    );

    tasks.add(task);
    storage.saveTasks(tasks);

    NotificationService.schedule(
      id: task.id,
      title: task.title,
      dateTime: task.dueTime,
    );

    notifyListeners();
  }

  bool toggleTask(int index, bool value) {
    final task = tasks[index];

    // if (task.dueTime.isAfter(DateTime.now())) {
    //   return false;
    // }

    task.completed = value;
    storage.saveTasks(tasks);

    if (value) {
      NotificationService.cancel(task.id);
    }

    notifyListeners();
    return true;
  }
}
