import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/pages/create_an_account_page.dart';

class IntroCreateAccountButton extends StatelessWidget {
  const IntroCreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.065,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CreateAnAccountPage();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: gray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Create an account',
            style: TextStyle(
              color: black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
