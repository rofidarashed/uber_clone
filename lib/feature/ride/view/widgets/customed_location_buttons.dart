import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/ride/cubit/location_cubit.dart';

class CustomedLocationButtons extends StatelessWidget {
  const CustomedLocationButtons({
    super.key,
    required this.fromLocation,
    required this.toLocation,
    required this.cubit,
    required this.selectingFrom,
    required this.onConfirmTap,
  });

  final LatLng? fromLocation;
  final LatLng? toLocation;
  final LocationCubit cubit;
  final bool selectingFrom;
  final VoidCallback onConfirmTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fromLocation != null
                        ? 'From: ${fromLocation!.latitude.toStringAsFixed(4)}, ${fromLocation!.longitude.toStringAsFixed(4)}'
                        : 'Tap on map to select starting point',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    toLocation != null
                        ? 'To: ${toLocation!.latitude.toStringAsFixed(4)}, ${toLocation!.longitude.toStringAsFixed(4)}'
                        : 'Tap again to select destination',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(
                  onPressed: () => cubit.setFrom(latLng: fromLocation!),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectingFrom
                            ? Colors.green.withOpacity(0.2)
                            : null,
                  ),
                  child: Text(
                    "Set From",
                    style: TextStyle(color: black),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => cubit.setTo(latLng: toLocation!, ),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectingFrom
                            ? null
                            : Colors.red.withOpacity(0.2),
                  ),
                  child: Text("Set To", style: TextStyle(color: black)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed:
                      (fromLocation != null && toLocation != null)
                          ? () {
                            debugPrint(
                              "Confirmed: From $fromLocation To $toLocation",
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Durations.medium4,
                                content: Text(
                                  "Confirmed: From $fromLocation To $toLocation",
                                ),
                              ),
                            );
                            onConfirmTap();
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child:  Text(
                    "Confirm",
                    style: TextStyle(color: white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


