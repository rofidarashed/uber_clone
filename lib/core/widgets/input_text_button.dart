// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/elements/size_extensions.dart';

class InputTextButton extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  const InputTextButton({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    required this.obscureText,
    this.textInputType,
    this.textInputFormatter, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.rh),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: textInputType,
        inputFormatters: textInputFormatter,
        decoration: InputDecoration(
          prefixIcon: prefixIcon ,
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
