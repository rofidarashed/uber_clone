import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class DriverInfo extends StatelessWidget {
  final DocumentSnapshot drivers;

 const DriverInfo({super.key, required this.drivers,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.rh),
      child: Row(
        children: [
          CircleAvatar(
            radius: 31.rh,
            backgroundColor: white,
            backgroundImage: AssetImage(drivers['image']),
          ),
          SizedBox(width: 18.rw),
          Text(drivers['Name'], style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
