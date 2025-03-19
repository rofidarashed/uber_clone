import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/widgets/create_an_account_button.dart';
import 'package:uber/widgets/input_text_button.dart';

class CreateAnAccountPage extends StatelessWidget {
  const CreateAnAccountPage({super.key});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8,
                    top: MediaQuery.of(context).size.height / 20,
                    bottom: MediaQuery.of(context).size.height / 15,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height * 0.132,
                        child: Image.asset(
                          "assets/logoDark.png",
                          width: double.minPositive,
                        ),
                      ),
                      Text(
                        'Create an account.',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .062,
                      ),
                      InputTextButton(
                        labelText: 'E-mail',
                        hintText: 'qwerty@gmail.com',
                      ),
                      InputTextButton(labelText: 'Password', hintText: '*****'),
                      InputTextButton(
                        labelText: 'Repeat Password',
                        hintText: '*****',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'By creating an account, you agree\nto our Terms of Service and Privacy Policy.',
                  ),
                  CreateAnAccountButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
