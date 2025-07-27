import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:uber/feature/ride/cubit/location_cubit.dart';
import 'package:uber/feature/ride/data/get_current_location.dart';

class MapFloatingIcons extends StatelessWidget {
  const MapFloatingIcons({
    super.key,
    required this.cubit,
    required this.mapController,
    required this.isLoadingLocation,
  });

  final LocationCubit cubit;
  final MapController mapController;
  final bool isLoadingLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          mini: true,
          backgroundColor: Colors.white,
          onPressed: () {
            cubit.handleMyLocation(
              getCurrentLocation: () => getCurrentLocation(context),
              mapController: mapController,
            );
          },
          child:
              isLoadingLocation
                  ? const CircularProgressIndicator(strokeWidth: 2)
                  : const Icon(Icons.my_location, color: Colors.black),
        ),
        FloatingActionButton(
          mini: true,
          backgroundColor: Colors.white,
          onPressed: isLoadingLocation ? null : cubit.resetLocations,
          child: const Icon(Icons.replay, color: Colors.black),
        ),
      ],
    );
  }
}
