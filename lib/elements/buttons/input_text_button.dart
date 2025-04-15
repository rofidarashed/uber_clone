// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:uber/colors/colors.dart';

class InputTextButton extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  const InputTextButton({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,

        decoration: InputDecoration(
          filled: true,
          fillColor: gray0,
          label: Text(labelText),
          labelStyle: TextStyle(color: gray2, fontWeight: FontWeight.w500),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: TextStyle(color: gray1),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
