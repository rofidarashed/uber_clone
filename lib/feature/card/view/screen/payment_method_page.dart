import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/elements/size_extensions.dart';
import 'package:uber/feature/card/view/screen/card_details_page.dart';

class PaymentMethodPage extends StatelessWidget {
  final int amount;
  const PaymentMethodPage({super.key,required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(backgroundColor: white),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CardDetailsPage(amount: amount, );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
