import 'package:geolocator/geolocator.dart';

class GeoUtils {
  static double distanceBetween({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  /// Checks if a user is within a certain radius (meters) of a location
  static bool isWithinRadius({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
    required double radiusInMeters,
  }) {
    final distance = distanceBetween(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );
    return distance <= radiusInMeters;
  }

  /// Converts meters to kilometers
  static double metersToKm(double meters) => meters / 1000;
}
