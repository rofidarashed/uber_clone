import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/login/view/screens/forgot_password_page.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ForgotPasswordPage();
            },
          ),
        );
      },
      child: Text(
        'Forgot your password?',
        style: TextStyle(color: black),
      ),
    );
  }
}
