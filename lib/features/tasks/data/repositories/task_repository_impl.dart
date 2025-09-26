import 'dart:async';
import 'dart:convert';
import '../../domain/entities/task.dart';
import '../datasources/task_remote_datasource.dart';
import '../../../../../services/websocket_service.dart';
import '../../../../../services/local_storage_service.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl {
  final TaskRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage;
  final WebSocketService wsService;

  StreamController<List<TaskModel>>? _controller;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.wsService,
  });

  Future<List<TaskModel>> getTasks() async {
    final response = await remoteDataSource.getTasks();
    final tasks = TaskModel.fromJsonList(response);
    await localStorage.saveTasks(tasks); // optional caching
    return tasks;
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final created = await remoteDataSource.createTask(task.toJson());
    final taskModel = TaskModel.fromJson(created);
    await localStorage.addTask(taskModel);
    return taskModel;
  }

  Future<TaskModel> updateTask(String id, TaskModel task) async {
    final updated = await remoteDataSource.updateTask(id, task.toJson());
    final taskModel = TaskModel.fromJson(updated);
    await localStorage.updateTask(taskModel);
    return taskModel;
  }

  Stream<List<TaskModel>> getTaskStream() {
    // Ensure WebSocket is connected
    wsService.connect();

    // Map stream of Map<String,dynamic> to List<TaskModel>
    return wsService.taskStreamController.map((list) => TaskModel.fromJsonList(list));
  }


  void disposeWebSocket() {
    _controller?.close();
    _controller = null;
  }
}
