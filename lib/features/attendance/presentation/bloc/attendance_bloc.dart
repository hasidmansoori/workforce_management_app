import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../data/models/attendance_model.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepositoryImpl attendanceRepository;
  // Example office coordinates (replace with your real location)
  final double officeLat = 12.9715987;
  final double officeLong = 77.594566;

  AttendanceBloc({required this.attendanceRepository}) : super(AttendanceInitial()) {
    on<CheckInRequested>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final id = await attendanceRepository.checkIn(officeLat, officeLong);
        emit(AttendanceSuccess(message: 'Checked in: \$id'));
      } catch (e) {
        emit(AttendanceError(message: e.toString()));
      }
    });

    on<CheckOutRequested>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final id = await attendanceRepository.checkOut(officeLat, officeLong);
        emit(AttendanceSuccess(message: 'Checked out: \$id'));
      } catch (e) {
        emit(AttendanceError(message: e.toString()));
      }
    });

    on<LoadAttendanceHistory>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final history = await attendanceRepository.getHistory();
        emit(AttendanceHistoryLoaded(records: history));
      } catch (e) {
        emit(AttendanceError(message: e.toString()));
      }
    });
  }
}
