import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/pages/home_page.dart';

class CreateAnAccountButton extends StatelessWidget {
  const CreateAnAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 26,
        horizontal: MediaQuery.of(context).size.width / 8,
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.065,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Create an account',
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
