import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, void>> checkIn();
  Future<Either<Failure, void>> checkOut();
  Future<Either<Failure, List<Attendance>>> getAttendanceHistory();
}
