  part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final String message;
  AttendanceSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AttendanceHistoryLoaded extends AttendanceState {
  final List<AttendanceModel> records;
  AttendanceHistoryLoaded({required this.records});
  @override
  List<Object?> get props => [records];
}
