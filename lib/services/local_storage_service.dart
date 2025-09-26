import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../features/tasks/data/models/task_model.dart';

class LocalStorageService {
  static const String userBox = 'userBox';
  static const String attendanceBox = 'attendanceBox';
  static const String tasksBox = 'tasksBox';
  Box? _taskBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _taskBox = await Hive.openBox('tasks');
  }

  Future<Box> openBox(String name) async {
    if (!Hive.isBoxOpen(name)) {
      return await Hive.openBox(name);
    }
    return Hive.box(name);
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    await _taskBox?.put('tasks', tasks.map((t) => t.toJson()).toList());
  }

  Future<void> addTask(TaskModel task) async {
    final current = _taskBox?.get('tasks', defaultValue: []) as List<dynamic>;
    current.add(task.toJson());
    await _taskBox?.put('tasks', current);
  }

  Future<void> updateTask(TaskModel task) async {
    final current = _taskBox?.get('tasks', defaultValue: []) as List<dynamic>;
    final idx = current.indexWhere((t) => t['id'] == task.id);
    if (idx >= 0) current[idx] = task.toJson();
    await _taskBox?.put('tasks', current);
  }

  List<TaskModel> getTasks() {
    final raw = _taskBox?.get('tasks', defaultValue: []) as List<dynamic>;
    return raw.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
