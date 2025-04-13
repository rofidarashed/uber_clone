import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/widgets/size_extensions.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Do This Later",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your payment \nmethod.",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.rh),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Image.asset(
                "assets/card.png",
                width: 50.rw,
                height: 50.rh,
              ),
              title: Text("Credit or Debit Card"),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Image.asset(
                "assets/cash.png",
                width: 50.rw,
                height: 50.rh,
              ),
              title: Text("Cash"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
