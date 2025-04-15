import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            "Account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("200", style: TextStyle(color: green, fontSize: 24)),
              Transform.translate(
                offset: Offset(0, -4),
                child: Text(
                  "EGP",
                  style: TextStyle(color: green, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
