import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, 
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (text.length > 16) {
      text = text.substring(0, 16);
    }
    
    var formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) formatted += ' ';
      formatted += text[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}