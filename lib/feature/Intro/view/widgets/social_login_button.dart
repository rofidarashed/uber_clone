import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/elements/size_extensions.dart';

class SocialLoginButton extends StatelessWidget {
  final String image;
  final VoidCallback onPress;
  const SocialLoginButton({
    super.key,
    required this.image,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 301.rw,
        height: 55.rh,
        decoration: BoxDecoration(
          border: Border.all(color: gray, width: 1.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              image,
              width: 35,
              height: 35,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
