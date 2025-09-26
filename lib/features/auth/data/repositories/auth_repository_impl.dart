import '../datasources/auth_remote_datasource.dart';
import '../../../../services/local_storage_service.dart';
import '../../domain/entities/user.dart';
import '../models/user_modal.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<void> saveToken(String token);
  Future<String?> getToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage;

  AuthRepositoryImpl({required this.remoteDataSource, required this.localStorage});

  @override
  Future<User> login(String email, String password) async {
    final model = await remoteDataSource.login(email, password);
    await saveToken(model.token);
    final box = await localStorage.openBox(LocalStorageService.userBox);
    await box.put('user', model.toJson());
    return model;
  }

  @override
  Future<User> register(String name, String email, String password) async {
    final model = await remoteDataSource.register(name, email, password);
    await saveToken(model.token);
    final box = await localStorage.openBox(LocalStorageService.userBox);
    await box.put('user', model.toJson());
    return model;
  }

  @override
  Future<void> saveToken(String token) async {
    final box = await localStorage.openBox(LocalStorageService.userBox);
    await box.put('token', token);
  }

  @override
  Future<String?> getToken() async {
    final box = await localStorage.openBox(LocalStorageService.userBox);
    return box.get('token') as String?;
  }
}
