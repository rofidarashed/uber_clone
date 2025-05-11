import 'package:flutter/material.dart';
import 'package:uber/elements/buttons/input_text_button.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class WhereToWigdet extends StatelessWidget {
  final TextEditingController from;
  final TextEditingController to;
  const WhereToWigdet({super.key, required this.from, required this.to});

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
                    controller: from,
                    obscureText: false,
                    validator: (value) => value == null || value.isEmpty ? "Required" : null,
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
                    controller: to,
                    obscureText: false,
                    validator:(value) => value == null || value.isEmpty ? "Required" : null,
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
