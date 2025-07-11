import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static const double earthRadiusKm = 6371.0;

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  bool isWithinRadius(
      double currentLat, double currentLon, double targetLat, double targetLon,
      {double radiusKm = 5}) {
    double distance =
        calculateDistance(currentLat, currentLon, targetLat, targetLon);

    return distance <= radiusKm;
  }
}

bool? getLocationStatus({
  final double? currentLatitude,
  final double? currentLongitude,
  final double? targetLatitude,
  final double? targetLongitude,
}) {
  // double targetLatitude = 37.4219983; // Example target latitude
  // double targetLongitude = -122.084; // Example target longitude
  bool withinRadius = LocationUtils().isWithinRadius(
    currentLatitude ?? 0.0,
    currentLongitude ?? 0.0,
    // 15.3487595 ?? 0.0,
    // 73.3471554 ?? 0.0,
    targetLatitude ?? 0.0,
    targetLongitude ?? 0.0,
  );

  print('withon radius ${withinRadius}');
  print(currentLatitude);
  print(currentLongitude);
  print(targetLatitude);
  print(targetLongitude);

  if (withinRadius) {
    return true;
  } else {
    return false;
  }
}

Future<void> getCurrentLocation({
  void Function(Position)? location,
}) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, request the user to enable them.
    return;
  }

  // Check if the permission to access location is granted
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Permission to access location is denied, request permission from the user.
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permission to access location is denied by the user.
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permission is denied forever, handle appropriately.
    return;
  }

  // When everything is fine, get the current location
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    location?.call(position);
  } catch (e) {}
}

Future<Position?> getCurrentLocations() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, request the user to enable them.
    return null;
  }

  // Check if the permission to access location is granted
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Permission to access location is denied, request permission from the user.
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permission to access location is denied by the user.
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permission is denied forever, handle appropriately.
    return null;
  }

  // When everything is fine, get the current location
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  } catch (e) {}
}

class GetLocation {
  GetLocation({this.locationn}) {
    getCurrentLocation();
  }
  final Function(Position? p)? locationn;

  Future<Position?> getCurrentLocation() async {
    // LocationPermission permission = await Geolocator.checkPermission();
    // permission = await Geolocator.requestPermission();
    // bool serviceEnabled;
    // LocationPermission permission;

    // Check if location services are enabled
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled, request the user to enable them.
    //   // return;
    // }

    // Check if the permission to access location is granted
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   // Permission to access location is denied, request permission from the user.
    // permission = await Geolocator.requestPermission();
    // }
    //
    // if (permission == LocationPermission.deniedForever) {
    //   // Permission is denied forever, handle appropriately.
    //    return null;
    // }

    // When everything is fine, get the current location
    // try {

    Position? position;
    // if (await getPermission()) {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
    // }
  }

  Future<bool> getPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request the user to enable them.
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permission to access location is denied, request permission from the user.
      // permission = await Geolocator.requestPermission();
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      // Permission is denied forever, handle appropriately.
      // return;
      return false;
    }
    if (permission == LocationPermission.whileInUse) {
      return true;
    }
    if (permission == LocationPermission.always) {
      return true;
    }
    return true;
  }
}
