import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class CarInfo extends StatelessWidget {
  final DocumentSnapshot driversCar;
  final Random random = Random();
  CarInfo({super.key, required this.driversCar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 70.rw,
            right: 70.rw,
            top: 44.rh,
            bottom: 28.rh,
          ),
          child: Image.asset("assets/car1.png"),
        ),
        Text(driversCar['Car_model'], style: TextStyle(fontSize: 24)),
        Text(
          "License Plate: ${driversCar['License_plate']}",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
