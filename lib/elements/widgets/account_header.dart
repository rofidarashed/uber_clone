import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/services/sp_service.dart';

class AccountHeader extends StatelessWidget {
  final int? balance = SpService.i.prefs!.getInt("balance") ?? 0;

  AccountHeader({super.key});

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
              Text(
                balance.toString(),
                style: TextStyle(color: green, fontSize: 24),
              ),
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
