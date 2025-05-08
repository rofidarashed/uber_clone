import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class DriverInfo extends StatelessWidget {
  final DocumentSnapshot drivers;

  final List<String> imagePaths = List.generate(
    10,
    (index) => 'assets/drivers/driver${index + 1}.jpg',
  );
  final Random random = Random();
  DriverInfo({super.key, required this.drivers});

  @override
  Widget build(BuildContext context) {
    final driverImage = imagePaths[random.nextInt(imagePaths.length)];
    return Container(
      padding: EdgeInsets.only(top: 20.rh),
      child: Row(
        children: [
          CircleAvatar(
            radius: 31.rh,
            backgroundColor: white,
            backgroundImage: AssetImage(driverImage),
          ),
          SizedBox(width: 18.rw),
          Text(drivers['Name'], style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
