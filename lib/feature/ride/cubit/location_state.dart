import 'package:latlong2/latlong.dart';

class LocationState {
  final LatLng? fromLocation;
  final LatLng? toLocation;
  final bool selectingFrom;
  final bool isLoadingLocation;
  final bool showInvalidLocationError;

  LocationState({
    required this.fromLocation,
    required this.toLocation,
    required this.selectingFrom,
    required this.isLoadingLocation,
    required this.showInvalidLocationError,
  });

  factory LocationState.initial() {
    return LocationState(
      fromLocation: const LatLng(0, 0),
      toLocation: null,
      selectingFrom: true,
      isLoadingLocation: false,
      showInvalidLocationError: false,
    );
  }

  LocationState copyWith({
    LatLng? fromLocation,
    LatLng? toLocation,
    bool? selectingFrom,
    bool? isLoadingLocation,
    bool? showInvalidLocationError,
  }) {
    return LocationState(
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      selectingFrom: selectingFrom ?? this.selectingFrom,
      isLoadingLocation: isLoadingLocation ?? this.isLoadingLocation,
      showInvalidLocationError: showInvalidLocationError ?? false,
    );
  }
}
