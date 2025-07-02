import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uber/core/utils/colors/colors.dart';

class WhereToWigdet extends StatefulWidget {
  final VoidCallback onConfirmTap;
  const WhereToWigdet({super.key, required this.onConfirmTap});

  @override
  State<WhereToWigdet> createState() => _WhereToWigdetState();
}

class _WhereToWigdetState extends State<WhereToWigdet> {
  final DocumentSnapshot? drivers = null;

  LatLng? fromLocation;
  LatLng? toLocation;
  bool selectingFrom = true;
  final mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(30.0444, 31.2357),
                initialZoom: 13,
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
                ),
                MarkerLayer(
                  markers: [
                    if (fromLocation != null)
                      Marker(
                        point: fromLocation!,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    if (toLocation != null)
                      Marker(
                        point: toLocation!,
                        child: Icon(
                          Icons.location_on,
                          color: red,
                          size: 40,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Container(
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
                      child: Text("Set From", style: TextStyle(color: black)),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectingFrom = false;
                        });
                      },
                      child: Text("Set To", style: TextStyle(color: black)),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed:
                          (fromLocation != null && toLocation != null)
                              ? () {
                                print(
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

                                widget.onConfirmTap();
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // SizedBox(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         "\tWhere to?",
    //         style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
    //       ),
    //       SizedBox(
    //         child: Row(
    //           children: [
    //             Icon(Icons.location_on_outlined, size: 39.rh),
    //             Expanded(
    //               child: InputTextButton(
    //                 labelText: "From",
    //                 hintText: "From",
    //                 controller: from,
    //                 obscureText: false,
    //                 validator: (value) => value == null || value.isEmpty ? "Required" : null,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         child: Row(
    //           children: [
    //             Icon(Icons.location_on_outlined, size: 39.rh),
    //             Expanded(
    //               child: InputTextButton(
    //                 labelText: "To",
    //                 hintText: "To",
    //                 controller: to,
    //                 obscureText: false,
    //                 validator:(value) => value == null || value.isEmpty ? "Required" : null,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
