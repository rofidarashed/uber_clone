import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 12,
        vertical: MediaQuery.of(context).size.height / 18,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: gray),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            Icon(Icons.arrow_forward, size: 24, color: black),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
