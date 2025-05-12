import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/elements/buttons/input_text_button.dart';
import 'package:uber/elements/services/sp_service.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/pages/card_details_page.dart';

class AddAmountPage extends StatefulWidget {
  const AddAmountPage({super.key});

  @override
  State<AddAmountPage> createState() => _AddAmountPageState();
}

class _AddAmountPageState extends State<AddAmountPage> {
  int balance = SpService.i.prefs!.getInt("balance") ?? 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add the amount you want",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        "Your current balance is ${balance.toString()} EGP",
                        style: TextStyle(color: gray4, fontSize: 20),
                      ),
                      SizedBox(height: 150.rh),
                      InputTextButton(
                        labelText: '200 EGP',
                        hintText: '200 EGP',
                        obscureText: false,
                        controller: _amount,
                        textInputType: TextInputType.number,
                        textInputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String? amount) {
                          if (amount?.isEmpty == true) {
                            return "Enter the amount";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.rw,
                  vertical: 18.rh,
                ),
                child: BlackButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final int amount = int.tryParse(_amount.text) ?? 0;
                      final int newBalance = balance + amount;
                      setState(() {
                        balance = newBalance;
                      });

                      SpService.i.prefs?.setInt('balance', newBalance);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CardDetailsPage();
                          },
                        ),
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
