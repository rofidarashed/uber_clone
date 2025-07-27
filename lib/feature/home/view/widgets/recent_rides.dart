import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/elements/size_extensions.dart';

class RecentRides extends StatelessWidget {
  final DocumentSnapshot rides;
  const RecentRides({super.key, required this.rides});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = rides.data() as Map<String, dynamic>;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: gray0,
      ),
      height: 70.rh,
      margin: EdgeInsets.symmetric(vertical: 7.rh),
      padding: EdgeInsets.only(
        top: 13.rh,
        bottom: 13.rh,
        left: 10.rw,
        right: 20.rw,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 50,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/car.png"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Uber Pool",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Text(
                    data['date'],
                    style: TextStyle(color: gray2, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 30.rw),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data['salary'],
                style: TextStyle(color: green, fontSize: 16),
              ),
              Transform.translate(
                offset: Offset(0, -4),
                child: Text(
                  "EGP",
                  style: TextStyle(color: green, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
