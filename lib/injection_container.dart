import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'services/api_service.dart';
import 'services/local_storage_service.dart';
import 'services/location_service.dart';
import 'core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/attendance/data/datasources/attendance_local_datasource.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/tasks/data/datasources/task_remote_datasource.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';
import 'services/websocket_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  // Services
  sl.registerLazySingleton(() => ApiService(sl<Dio>()));
  sl.registerLazySingleton(() => LocalStorageService());
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl<Connectivity>()));

  // WebSocket service (example URL; change to your ws endpoint)
  sl.registerFactory(() => WebSocketService('wss://example.com/ws'));

  // Initialize local storage (call init from main)
  await sl<LocalStorageService>().init();

  // Features - Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl<ApiService>()));
  sl.registerLazySingleton(() => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>(), localStorage: sl<LocalStorageService>()));
  sl.registerFactory(() => AuthBloc(authRepository: sl<AuthRepositoryImpl>()));

  // Features - Attendance
  sl.registerLazySingleton<AttendanceLocalDataSource>(() => AttendanceLocalDataSourceImpl(localStorage: sl<LocalStorageService>()));
  sl.registerLazySingleton(() => AttendanceRepositoryImpl(localDataSource: sl<AttendanceLocalDataSource>(), locationService: sl<LocationService>()));
  sl.registerFactory(() => AttendanceBloc(attendanceRepository: sl<AttendanceRepositoryImpl>()));

  // Features - Tasks
  sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImpl(sl<Dio >()));
  sl.registerLazySingleton(() => TaskRepositoryImpl(remoteDataSource: sl<TaskRemoteDataSource>(), localStorage: sl<LocalStorageService>(), wsService: sl<WebSocketService>()));
  sl.registerFactory(() => TaskBloc(taskRepository: sl<TaskRepositoryImpl>()));
}
