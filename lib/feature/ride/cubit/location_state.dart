import 'package:latlong2/latlong.dart';

class LocationState {
  final LatLng? fromLocation;
  final LatLng? toLocation;

  LocationState({this.fromLocation, this.toLocation});

  LocationState copyWith({LatLng? fromLocation, LatLng? toLocation}) {
    return LocationState(
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
    );
  }
}
