import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/services/user_service.dart';

class AccountHeader extends StatefulWidget {
  const AccountHeader({super.key});

  @override
  State<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  int balance = 0;
  StreamSubscription? _balanceSubscription;

  @override
  void initState() {
    super.initState();
    _setupBalanceListener();
  }

  void _setupBalanceListener() {
    _balanceSubscription = UserService.listenToUserBalance().listen(
      (snapshot) {
        if (!mounted) return;

        setState(() {
          balance = snapshot.data()?["balance"] ?? 0;
        });
      },
      onError: (error) {
        if (!mounted) return;
      },
    );
  }

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
