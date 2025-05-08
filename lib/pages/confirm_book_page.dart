import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/pages/payment_page.dart';

class ConfirmBook extends StatelessWidget {
  final DocumentSnapshot drivers;
  const ConfirmBook({super.key, required this.drivers});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentPage(drivers: drivers)),
      );
    });

    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/confirm.png", height: 124, width: 124),
            SizedBox(height: 48.rh),
            Text("Thank you", style: TextStyle(color: gray4, fontSize: 20)),
            Text(
              "Your booking has been confirmed and \nsent to \nMohamed",
              textAlign: TextAlign.center,
              style: TextStyle(color: gray4),
            ),
          ],
        ),
      ),
    );
  }
}
