import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String id;
  final DateTime checkIn;
  final DateTime? checkOut;
  final double latitude;
  final double longitude;

  const Attendance({
    required this.id,
    required this.checkIn,
    this.checkOut,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, checkIn, checkOut, latitude, longitude];
}
