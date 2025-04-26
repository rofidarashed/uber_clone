import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class ConfirmBook extends StatelessWidget {
  const ConfirmBook({super.key});

  @override
  Widget build(BuildContext context) {
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
