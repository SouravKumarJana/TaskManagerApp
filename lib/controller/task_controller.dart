import 'dart:async';
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../service/task_storage_service.dart';
import 'notification_controller.dart';

class TaskController extends ChangeNotifier {
  final TaskStorageService storage;
  List<Task> tasks = [];
  bool isLoading = true;
  Timer? _pollingTimer;

  TaskController(this.storage) {
    loadTasks();
    startPolling();
  }

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
    notifyListeners();
  }

  bool toggleTask(int index, bool value) {
    final task = tasks[index];

    if (value && task.dueTime.isAfter(DateTime.now())) {
      return false;
    }

    task.completed = value;

    if (value) {
      task.notified = true; // stop notification
    }

    storage.saveTasks(tasks);
    notifyListeners();
    return true;
  }

  void startPolling() {
    _pollingTimer =
        Timer.periodic(const Duration(seconds: 30), (_) {
      final now = DateTime.now();

      for (final task in tasks) {
        if (!task.completed &&
            !task.notified &&
            now.isAfter(task.dueTime)) {
          NotificationController.notifyTask(task);
          task.notified = true;
        }
      }

      storage.saveTasks(tasks);
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }
}
