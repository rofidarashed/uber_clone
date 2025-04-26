import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/elements/buttons/input_text_button.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: white),
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot password ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            Text(
              "Please enter your email to reset the\npassword ",
              style: TextStyle(fontSize: 18),
              maxLines: 2,
            ),
            SizedBox(height: 122.rh),
            InputTextButton(
              labelText: 'Enter your e-mail',
              hintText: 'qwerty@gmail.com',
              obscureText: false,
            ),
            SizedBox(height: 4.rh),
            BlackButton(onPressed: () {}, label: 'Reset Password  '),
          ],
        ),
      ),
    );
  }
}
