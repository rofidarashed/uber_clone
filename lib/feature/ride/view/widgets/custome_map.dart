import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/ride/cubit/location_cubit.dart';

class CustomedFlutterMap extends StatelessWidget {
  const CustomedFlutterMap({
    super.key,
    required this.mapController,
    required this.isDisabled,
    required this.cubit,
    required this.selectingFrom,
    required this.fromLocation,
    required this.toLocation,
  });

  final MapController mapController;
  final bool isDisabled;
  final LocationCubit cubit;
  final bool selectingFrom;
  final LatLng? fromLocation;
  final LatLng? toLocation;

  @override
  Widget build(BuildContext context) {
    print('object');
    print(fromLocation);
    print(toLocation);
    print('object');
    final bool validFrom =
        fromLocation != null &&
        fromLocation!.latitude.isFinite &&
        fromLocation!.longitude.isFinite;

    final bool validTo =
        toLocation != null &&
        toLocation!.latitude.isFinite &&
        toLocation!.longitude.isFinite;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(30.0444, 31.2357),
        initialZoom: (13.0).clamp(10.0, 18.0),
        onTap: (tapPosition, point) {
          debugPrint('tapped');
          print('tapped');
          print('tapeed');
          print('tapred');
          print('tapued');
          cubit.updateLocation(
            newLocation: point,
            selectingFrom: selectingFrom,
          );
        },
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.rofida.uber',
        ),
        if (validFrom && validTo)
          PolylineLayer(
            polylines: [
              Polyline(
                points: [fromLocation!, toLocation!],
                strokeWidth: 6.0,
                color: Colors.blue,
                borderColor: Colors.white,
                borderStrokeWidth: 2.0,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            if (validFrom)
              Marker(
                point: fromLocation!,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            if (validTo)
              Marker(
                point: toLocation!,
                child: Icon(Icons.location_on, color: red, size: 40),
              ),
          ],
        ),
      ],
    );
  }
}
