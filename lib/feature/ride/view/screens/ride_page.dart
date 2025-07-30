import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/ride/view/widgets/available_rides.dart';
import 'package:uber/core/elements/size_extensions.dart';
import 'package:uber/feature/ride/view/widgets/where_to_wigdet.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  bool isComfirmed = false;
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Drivers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: black));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        }
        final drivers = snapshot.data!.docs;
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.rw, vertical: 30.rh),
              child: Column(
                children: [
                  isComfirmed
                      ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Available Rides",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isComfirmed = false;
                                    });
                                  },
                                  icon: Icon(Icons.replay),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: drivers.length,
                                itemBuilder: (context, index) {
                                  var driver = drivers[index];

                                  return AvailableRides(drivers: driver);
                                },
                              ),
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      )
                      : WhereToWidget(
                        onConfirmTap: () {
                          setState(() {
                            isComfirmed = true;
                          });
                        },
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
