import 'dart:async';
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../service/task_storage_service.dart';
import '../service/local_notification_service.dart';

class TaskController extends ChangeNotifier {
  final TaskStorageService storageService;

  TaskController(this.storageService);

  List<Task> tasks = [];
  bool isLoading = true;
  Timer? _timer;

  Future<void> loadTasks() async {
    tasks = await storageService.loadTasks();
    isLoading = false;
    _startDueTimeWatcher();
    notifyListeners();
  }

  void addTask(String title, DateTime dueTime) {
    tasks.add(Task(title: title, dueTime: dueTime));
    storageService.saveTasks(tasks);
    notifyListeners();
  }

  bool canCompleteTask(int index) {
    return DateTime.now().isAfter(tasks[index].dueTime);
  }

  void toggleTask(int index, bool value) {
    if (value && !canCompleteTask(index)) {
      return;
    }

    tasks[index].completed = value;
    storageService.saveTasks(tasks);
    notifyListeners();
  }

  void _startDueTimeWatcher() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      final now = DateTime.now();

      for (final task in tasks) {
        if (!task.completed && ! task.notified &&
            now.year == task.dueTime.year &&
            now.month == task.dueTime.month &&
            now.day == task.dueTime.day &&
            now.hour == task.dueTime.hour &&
            now.minute == task.dueTime.minute) {
          NotificationService.showNotification(
            'Task Due',
            task.title,
          );
        task.notified = true; 
        storageService.saveTasks(tasks);
        }
        
  
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
