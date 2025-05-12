import 'package:flutter/services.dart';

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, 
    TextEditingValue newValue,
  ) {
    var newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    if (newText.length >= 2) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}