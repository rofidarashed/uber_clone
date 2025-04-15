import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/pages/payment_method_page.dart';
import 'package:uber/elements/widgets/account_header.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 20.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountHeader(),
            SizedBox(height: 30.rh),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Profile',
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 18.rh),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PaymentMethodPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Top-up balance',
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.rh),
                    child: Divider(thickness: 1.3),
                  ),
                  InkWell(
                    child: Text(
                      "Setting",
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 18.rh),

                  InkWell(
                    child: Text(
                      "Log out",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
