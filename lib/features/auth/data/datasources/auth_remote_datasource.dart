import 'package:dio/dio.dart';
import '../../../../services/api_service.dart';
import '../models/user_modal.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await apiService.dio.post('/auth/login', data: {'email': email, 'password': password});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(response.data['data'] ?? response.data);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await apiService.dio.post('/auth/register', data: {'name': name, 'email': email, 'password': password});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(response.data['data'] ?? response.data);
    } else {
      throw Exception('Failed to register');
    }
  }
}
