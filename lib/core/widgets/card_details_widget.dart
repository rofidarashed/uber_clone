import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber/core/elements/size_extensions.dart';
import 'package:uber/core/widgets/input_text_button.dart';
import 'package:uber/feature/card/view/widgets/card_number_input_formatter.dart';
import 'package:uber/feature/account/view/widgets/expiry_date_input_formatter.dart';

class CardDetailsWidget extends StatelessWidget {
  const CardDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Enter the debit/credit card details",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        InputTextButton(
          labelText: 'Cardholder name',
          hintText: 'Cardholder name',
          obscureText: false,
        ),
        InputTextButton(
          labelText: 'Card number',
          hintText: 'XXXX XXXX XXXX XXXX',
          obscureText: false,
          prefixIcon: Icon(Icons.credit_card),
          textInputType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            CardNumberInputFormatter(),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter card number';
            }
            final cleanValue = value.replaceAll(' ', '');
            if (cleanValue.length < 16 ||
                !RegExp(r'^[0-9]{16}$').hasMatch(cleanValue)) {
              return 'Invalid card number';
            }
            return null;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 160.rw,
              child: InputTextButton(
                labelText: 'Expiry date',
                hintText: 'MM/YY',
                obscureText: false,
                textInputType: TextInputType.number,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  ExpiryDateInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter expiry date';
                  }
                  final cleanValue = value.replaceAll('/', '');
    
                  if (cleanValue.length != 4) {
                    return 'Invalid date';
                  }
    
                  final month = int.tryParse(
                    cleanValue.substring(0, 2),
                  );
                  final year = int.tryParse(
                    cleanValue.substring(2),
                  );
                  if (month == null || month < 1 || month > 12) {
                    return 'Invalid month';
                  }
                  final currentYear = DateTime.now().year % 100;
                  final currentMonth = DateTime.now().month;
    
                  if (year == null ||
                      year < currentYear ||
                      (year == currentYear &&
                          month < currentMonth)) {
                    return 'Card expired';
                  }
    
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 160.rw,
              child: InputTextButton(
                labelText: 'CVV',
                hintText: 'CVV',
                obscureText: false,
                textInputType: TextInputType.number,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter CVV';
                  }
                  if (!RegExp(r'^[0-9]{3,4}$').hasMatch(value)) {
                    return 'Invalid CVV';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
