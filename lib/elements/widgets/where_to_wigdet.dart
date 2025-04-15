import 'package:flutter/material.dart';
import 'package:uber/elements/buttons/input_text_button.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class WhereToWigdet extends StatelessWidget {
  const WhereToWigdet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\tWhere to?",
            style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, size: 39.rh),
                Expanded(
                  child: InputTextButton(
                    labelText: "From",
                    hintText: "From",
                    obscureText: false,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, size: 39.rh),
                Expanded(
                  child: InputTextButton(
                    labelText: "To",
                    hintText: "To",
                    obscureText: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
