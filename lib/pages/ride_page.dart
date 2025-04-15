import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/available_rides.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/elements/widgets/where_to_wigdet.dart';

class RidePage extends StatelessWidget {
  const RidePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return AvailableRides();
                  },
                ),
              ),
              SizedBox(height: 40.rh),
            ],
          ),
        ),
      ),
    );
  }
}
