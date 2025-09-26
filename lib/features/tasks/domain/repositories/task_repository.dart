import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../data/models/task_model.dart';

class TaskRepositoryImpl {
  final Dio dio;
  final String wsUrl;
  WebSocketChannel? _channel;

  TaskRepositoryImpl({required this.dio, required this.wsUrl});

  Future<List<TaskModel>> getTasks() async {
    final response = await dio.get('/tasks');
    final data = response.data as List<dynamic>;
    return TaskModel.fromJsonList(data);
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final response = await dio.post('/tasks', data: task.toJson());
    return TaskModel.fromJson(response.data);
  }

  Future<TaskModel> updateTask(String id, TaskModel task) async {
    final response = await dio.put('/tasks/$id', data: task.toJson());
    return TaskModel.fromJson(response.data);
  }

  /// WebSocket stream correctly typed
  Stream<List<TaskModel>> getTaskStream() {
    _channel ??= WebSocketChannel.connect(Uri.parse(wsUrl));
    return _channel!.stream.map<List<TaskModel>>((message) {
      final decoded = json.decode(message);
      return TaskModel.fromJsonList(decoded as List<dynamic>);
    });
  }

  /// Dispose WebSocket properly
  void disposeWebSocket() {
    _channel?.sink.close();
    _channel = null;
  }
}
