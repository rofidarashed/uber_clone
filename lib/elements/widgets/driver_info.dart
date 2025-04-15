import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.rh),
      child: Row(
        children: [
          CircleAvatar(
            radius: 29,
            backgroundColor: white,
            child: Image.asset(
              "assets/driver.png",
              height: 58.rh,
              width: 58.rw,
            ),
          ),
          Text("\tMohamed", style: TextStyle(fontSize: 24)),
          
        ],
      ),
    );
  }
}
