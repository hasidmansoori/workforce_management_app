import '../../data/datasources/attendance_local_datasource.dart';
import '../../../../services/location_service.dart';
import '../models/attendance_model.dart';
import 'package:uuid/uuid.dart';

abstract class AttendanceRepository {
  Future<String> checkIn(double officeLat, double officeLong);
  Future<String> checkOut(double officeLat, double officeLong);
  Future<List<AttendanceModel>> getHistory();
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceLocalDataSource localDataSource;
  final LocationService locationService;
  final _uuid = const Uuid();

  AttendanceRepositoryImpl({required this.localDataSource, required this.locationService});

  static const double allowedRadiusMeters = 50.0;

  Future<bool> _isWithinOffice(double officeLat, double officeLong) async {
    final pos = await locationService.getCurrentPosition();
    final distance = locationService.distanceBetween(pos.latitude, pos.longitude, officeLat, officeLong);
    return distance <= allowedRadiusMeters;
  }

  @override
  Future<String> checkIn(double officeLat, double officeLong) async {
    final within = await _isWithinOffice(officeLat, officeLong);
    if (!within) throw Exception('Not within office geofence');

    final id = _uuid.v4();
    final model = AttendanceModel(id: id, timestamp: DateTime.now().toUtc(), latitude: officeLat, longitude: officeLong, type: 'check-in');
    await localDataSource.cacheAttendance(model);
    return id;
  }

  @override
  Future<String> checkOut(double officeLat, double officeLong) async {
    final within = await _isWithinOffice(officeLat, officeLong);
    if (!within) throw Exception('Not within office geofence');

    final id = _uuid.v4();
    final model = AttendanceModel(id: id, timestamp: DateTime.now().toUtc(), latitude: officeLat, longitude: officeLong, type: 'check-out');
    await localDataSource.cacheAttendance(model);
    return id;
  }

  @override
  Future<List<AttendanceModel>> getHistory() async {
    return await localDataSource.getAttendanceHistory();
  }
}
