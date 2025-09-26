import 'package:hive/hive.dart';
import '../models/attendance_model.dart';
import '../../../../services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

abstract class AttendanceLocalDataSource {
  Future<void> cacheAttendance(AttendanceModel model);
  Future<List<AttendanceModel>> getAttendanceHistory();
}

class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  final LocalStorageService localStorage;
  AttendanceLocalDataSourceImpl({required this.localStorage});

  final _uuid = const Uuid();

  @override
  Future<void> cacheAttendance(AttendanceModel model) async {
    final box = await localStorage.openBox(LocalStorageService.attendanceBox);
    final list = box.get('records', defaultValue: <Map>[]).cast<Map>().toList();
    list.add(model.toJson());
    await box.put('records', list);
  }

  @override
  Future<List<AttendanceModel>> getAttendanceHistory() async {
    final box = await localStorage.openBox(LocalStorageService.attendanceBox);
    final list = box.get('records', defaultValue: <Map>[]).cast<Map>().toList();
    return list.map((e) => AttendanceModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}
