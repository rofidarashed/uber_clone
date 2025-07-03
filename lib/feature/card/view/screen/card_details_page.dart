import 'package:flutter/material.dart';
import 'package:uber/core/services/user_service.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/core/widgets/card_details_widget.dart';
import 'package:uber/core/elements/size_extensions.dart';
import 'package:uber/feature/home/view/screens/navigator_page.dart';

class CardDetailsPage extends StatefulWidget {
  final int amount;
  const CardDetailsPage({super.key, required this.amount});

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    right: 28.rw,
                    left: 28.rw,
                    top: 50.rh,
                  ),
                  child: CardDetailsWidget(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.rw,
                  vertical: 18.rh,
                ),
                child: BlackButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      int currentBalance = await UserService.getUserBalance();
                      int newBalance = currentBalance;

                      newBalance = currentBalance + widget.amount;

                      await UserService.updateUserBalance(newBalance);

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  label: 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
