class AttendanceModel {
  final String id;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String type; // check-in or check-out
  AttendanceModel({required this.id, required this.timestamp, required this.latitude, required this.longitude, required this.type});

  Map<String, dynamic> toJson() => {
    'id': id,
    'timestamp': timestamp.toIso8601String(),
    'latitude': latitude,
    'longitude': longitude,
    'type': type,
  };

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    id: json['id'].toString(),
    timestamp: DateTime.parse(json['timestamp']),
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    type: json['type'],
  );
}
