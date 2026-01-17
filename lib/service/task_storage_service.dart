import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task.dart';

class TaskStorageService {
  static const _key = 'tasks';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tasks.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final list = jsonDecode(data) as List;
    return list.map((e) => Task.fromJson(e)).toList();
  }
}
