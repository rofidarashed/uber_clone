import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/services/user_service.dart';

class AccountHeader extends StatefulWidget {
  const AccountHeader({super.key});

  @override
  State<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  int balance = 0;
  void _setupBalanceListener() {
    UserService.listenToUserBalance().listen(
      (snapshot) {
        if (!mounted) return;
        if (snapshot.exists) {
          setState(() {
            balance = snapshot.data()?["balance"] ?? 0;
          });
        }
      },
      onError: (error) {
        if (!mounted) return;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setupBalanceListener();
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
