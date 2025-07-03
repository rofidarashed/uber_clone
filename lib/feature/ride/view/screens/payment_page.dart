import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/core/services/user_service.dart';
import 'package:uber/feature/ride/view/screens/confirm_book_page.dart';
import 'package:uber/feature/ride/view/widgets/car_info.dart';
import 'package:uber/core/elements/size_extensions.dart';

class PaymentPage extends StatelessWidget {
  final DocumentSnapshot drivers;
  const PaymentPage({super.key, required this.drivers});

  @override
  Widget build(BuildContext context) {
    final int uberFee = 10;
    final int driverFee = int.tryParse(drivers['salary']) ?? 0;
    final int total = uberFee + driverFee;
    return Scaffold(
      appBar: AppBar(backgroundColor: white),
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarInfo(driversCar: drivers),
              Text('\nCharge\n', style: TextStyle(color: gray4, fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Driver Fee'),
                  Text(
                    "EGP ${driverFee.toString()}",
                    style: TextStyle(color: green),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Uber Fee'),
                  Text(
                    'EGP ${uberFee.toString()}',
                    style: TextStyle(color: green),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        total.toString(),
                        style: TextStyle(
                          color: green,
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -9),
                        child: Text('EGP', style: TextStyle(color: green)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100.rh),
              BlackButton(
                onPressed: () async {
                  int balance = await UserService.getUserBalance();
                  if (balance >= total) {
                    balance -= total;
                    Future.delayed(Duration(microseconds: 5));
                    await UserService.updateUserBalance(balance);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Payment done successfully"),
                        backgroundColor: green,
                        duration: Durations.medium4,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ConfirmBook(drivers: drivers);
                        },
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Not enough balance!"),
                        duration: Durations.medium4,
                        backgroundColor: red,
                      ),
                    );
                  }
                },
                label: 'pay',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
