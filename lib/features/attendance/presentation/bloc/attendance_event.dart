part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckInRequested extends AttendanceEvent {}

class CheckOutRequested extends AttendanceEvent {}

class LoadAttendanceHistory extends AttendanceEvent {}
