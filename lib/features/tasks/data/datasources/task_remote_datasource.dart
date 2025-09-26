import 'package:dio/dio.dart';

abstract class TaskRemoteDataSource {
  Future<List<Map<String, dynamic>>> getTasks();
  Future<Map<String, dynamic>> createTask(Map<String, dynamic> task);
  Future<Map<String, dynamic>> updateTask(String id, Map<String, dynamic> task);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getTasks() async {
    final response = await dio.get('/tasks');
    final data = response.data as List<dynamic>;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  Future<Map<String, dynamic>> createTask(Map<String, dynamic> task) async {
    final response = await dio.post('/tasks', data: task);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateTask(String id, Map<String, dynamic> task) async {
    final response = await dio.put('/tasks/$id', data: task);
    return response.data as Map<String, dynamic>;
  }
}
