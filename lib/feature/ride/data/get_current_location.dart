import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/core/utils/colors/colors.dart';

Future<LatLng?> getCurrentLocation(context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Durations.medium4,
        backgroundColor: green.withOpacity(0.5),
        content: Text("Location services are disabled."),
      ),
    );
    return null;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Durations.medium4,
          backgroundColor: red.withOpacity(0.5),
          content: Text("Location permissions are denied."),
        ),
      );
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Durations.medium4,
        backgroundColor: red.withOpacity(0.5),
        content: Text("Location permissions are permanently denied."),
      ),
    );
    return null;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Durations.medium4,
        backgroundColor: red.withOpacity(0.5),
        content: Text("Error fetching location: $e"),
      ),
    );
    return null;
  }
}
