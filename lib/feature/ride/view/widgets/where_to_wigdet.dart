import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/core/utils/colors/colors.dart';

class WhereToWidget extends StatefulWidget {
  final VoidCallback onConfirmTap;
  const WhereToWidget({super.key, required this.onConfirmTap});

  @override
  State<WhereToWidget> createState() => _WhereToWidgetState();
}

class _WhereToWidgetState extends State<WhereToWidget> {
  Position? currentPosition;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = position;
      fromLocation = LatLng(position.latitude, position.longitude);
      mapController.move(fromLocation!, 15);
    });
  }

  LatLng? fromLocation;
  LatLng? toLocation;
  bool selectingFrom = true;
  final mapController = MapController();
  LatLng initialCenter = LatLng(30.0444, 31.2357);
  final initialZoom = 13.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          _buildMap(),
          Positioned(top: 20, right: 10, child: _buildFloatingButtons()),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildLocationInfo()),
        ],
      ),
    );
  }

  FlutterMap _buildMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
        onTap: (tapPosition, point) {
          setState(() {
            if (selectingFrom) {
              fromLocation = point;
            } else {
              toLocation = point;
            }
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.rofida.uber',
        ),
        MarkerLayer(
          markers: [
            if (fromLocation != null)
              Marker(
                point: fromLocation!,
                child: Icon(Icons.location_on, color: Colors.green, size: 40),
              ),
            if (toLocation != null)
              Marker(
                point: toLocation!,
                child: Icon(Icons.location_on, color: red, size: 40),
              ),
          ],
        ),
      ],
    );
  }

  Column _buildFloatingButtons() {
    return Column(
      children: [
        FloatingActionButton(
          mini: true,
          backgroundColor: white.withOpacity(.8),
          onPressed: () => _getCurrentLocation(),
          child: Icon(Icons.my_location, color: black),
        ),
        FloatingActionButton(
          mini: true,
          backgroundColor: white.withOpacity(.8),
          onPressed: () {
            setState(() {
              fromLocation = null;
              toLocation = null;
              selectingFrom = true;
              mapController.move(initialCenter, initialZoom);
            });
          },
          child: Icon(Icons.replay, color: black),
        ),
      ],
    );
  }

  Container _buildLocationInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                onPressed: () {
                  setState(() {
                    selectingFrom = true;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      selectingFrom ? Colors.green.withOpacity(0.2) : null,
                ),
                child: Text("Set From", style: TextStyle(color: black)),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectingFrom = false;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      selectingFrom ? null : Colors.pink.withOpacity(0.2),
                ),
                child: Text("Set To", style: TextStyle(color: black)),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed:
                    (fromLocation != null && toLocation != null)
                        ? () {
                          print("Confirmed: From $fromLocation To $toLocation");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Durations.medium4,
                              content: Text(
                                "Confirmed: From $fromLocation To $toLocation",
                              ),
                            ),
                          );

                          widget.onConfirmTap();
                        }
                        : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
