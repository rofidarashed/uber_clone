import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String image;
  final VoidCallback onPress;
  const SocialLoginButton({super.key, required this.image,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ,
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          border: Border.all(color: gray, width: 1.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.07,
              height: MediaQuery.of(context).size.height * 0.04,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
