import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';

class InputTextButton extends StatelessWidget {
  final String labelText;
  final String hintText;
  const InputTextButton({
    super.key,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: black,
        decoration: InputDecoration(
          filled: true,
          fillColor: gray0,
          label: Text(labelText),
          labelStyle: TextStyle(color: gray2),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: TextStyle(color: gray1),

          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
