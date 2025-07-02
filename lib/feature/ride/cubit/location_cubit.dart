import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/feature/ride/cubit/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState());

  void setFrom( {required LatLng latLng}) {
    emit(state.copyWith(fromLocation: latLng,));
  }

  void setTo({required LatLng latLng}) {
    emit(state.copyWith(toLocation: latLng,));
  }

  void clear() {
    emit(LocationState());
  }

 
}
