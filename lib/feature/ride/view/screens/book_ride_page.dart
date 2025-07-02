import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/feature/ride/view/screens/payment_page.dart';
import 'package:uber/feature/ride/view/widgets/car_info.dart';
import 'package:uber/feature/ride/view/widgets/driver_info.dart';
import 'package:uber/core/elements/size_extensions.dart';

class BookRidePage extends StatelessWidget {
  final DocumentSnapshot drivers;
  const BookRidePage({super.key, required this.drivers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 28.rh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, size: 30, color: black),
                  ),
                  Text(
                    "\tBook a ride?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CarInfo(driversCar: drivers,),
              SizedBox(height: 34),
              Text(
                "Driver",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              DriverInfo(drivers: drivers),
              SizedBox(height: 140.rh),
              BlackButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PaymentPage(drivers: drivers,);
                      },
                    ),
                  );
                },
                label: "Book",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
