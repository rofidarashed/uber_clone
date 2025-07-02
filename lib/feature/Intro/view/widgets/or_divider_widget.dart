import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'or',
            style: TextStyle(
              color: gray1,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
