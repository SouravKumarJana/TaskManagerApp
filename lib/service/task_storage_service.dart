import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task.dart';

class TaskStorageService {
  static const _key = 'tasks';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, data);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }
}
