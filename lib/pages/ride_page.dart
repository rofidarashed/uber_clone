import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/available_rides.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/elements/widgets/where_to_wigdet.dart';

class RidePage extends StatelessWidget {
  const RidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Drivers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: black));
        }
        final drivers = snapshot.data!.docs;
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.rw, vertical: 29.rh),
              child: Column(
                children: [
                  WhereToWigdet(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.rh),
                    child: Divider(thickness: 1.3),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: drivers.length,
                      itemBuilder: (context, index) {
                      var driver = drivers[index];

                        return AvailableRides(driversname: driver);
                      },
                    ),
                  ),
                  SizedBox(height: 40.rh),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
