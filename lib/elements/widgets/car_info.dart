import 'package:flutter/material.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class CarInfo extends StatelessWidget {
  const CarInfo({super.key});

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
        Text(" Red Hyundai Matrix 2020", style: TextStyle(fontSize: 24)),
        Text(" License Plate: ABC123", style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
