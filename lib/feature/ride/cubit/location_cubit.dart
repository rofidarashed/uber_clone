import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/feature/ride/cubit/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  bool _isValidLocation(LatLng? latLng) {
    return latLng != null &&
        latLng.latitude.isFinite &&
        latLng.longitude.isFinite &&
        latLng.latitude.abs() <= 90 &&
        latLng.longitude.abs() <= 180;
  }


  void setFrom({required LatLng latLng}) {
    print('setFrom called with latLng: $latLng');
    if (!_isValidLocation(latLng)) {
      print('Invalid location coordinates');
      emit(state.copyWith(showInvalidLocationError: true));
      return;
    }
    emit(state.copyWith(fromLocation: latLng, selectingFrom: false));
  }

  void setTo({required LatLng latLng}) {
    print('setTo called with latLng: $latLng');
    if (!_isValidLocation(latLng)) {
      emit(state.copyWith(showInvalidLocationError: true));
      return;
    }
    emit(state.copyWith(toLocation: latLng, selectingFrom: true));
  }

  void updateLocation({LatLng? newLocation, required bool selectingFrom}) {
    if (!_isValidLocation(newLocation)) {
      emit(state.copyWith(showInvalidLocationError: true));
      return;
    }

    if (selectingFrom) {
      emit(state.copyWith(fromLocation: newLocation));
    } else {
      emit(state.copyWith(toLocation: newLocation));
    }
  }

  Future<void> handleMyLocation({
    required Future<LatLng?> Function() getCurrentLocation,
    required MapController mapController,
  }) async {
    emit(state.copyWith(isLoadingLocation: true));

    final currentLocation = await getCurrentLocation();
    if (_isValidLocation(currentLocation)) {
      updateLocation(
        newLocation: currentLocation,
        selectingFrom: state.selectingFrom,
      );
      mapController.move(currentLocation!, 15.0.clamp(10.0, 18.0));
    } else {
      emit(state.copyWith(showInvalidLocationError: true));
    }

    emit(state.copyWith(isLoadingLocation: false));
  }

  void resetLocations() {
    emit(
      state.copyWith(fromLocation: null, toLocation: null, selectingFrom: true),
    );
  }

  void toggleSelectingFrom() {
    emit(state.copyWith(selectingFrom: !state.selectingFrom));
  }

  void clearError() {
    emit(state.copyWith(showInvalidLocationError: false));
  }
}
