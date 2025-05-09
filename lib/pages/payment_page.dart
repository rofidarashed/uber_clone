import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/elements/widgets/car_info.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/pages/ride_page.dart';

class PaymentPage extends StatelessWidget {
  final DocumentSnapshot drivers;
  const PaymentPage({super.key, required this.drivers});

  @override
  Widget build(BuildContext context) {
    final int uberFee = 10;
    final int driverFee = int.tryParse(drivers['salary'] )??0;
    final int total = uberFee + driverFee;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 28.rh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarInfo(driversCar: drivers),
              Text('\nCharge\n', style: TextStyle(color: gray4, fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Driver Fee'),
                  Text("EGP ${driverFee.toString()}", style: TextStyle(color: green)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Uber Fee'),
                  Text('EGP ${uberFee.toString()}', style: TextStyle(color: green)),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        total.toString(),
                        style: TextStyle(
                          color: green,
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -9),
                        child: Text('EGP', style: TextStyle(color: green)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 150.rh),
              BlackButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RidePage();
                      },
                    ),
                  );
                },
                label: 'pay',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
