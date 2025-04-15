import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/pages/book_ride_page.dart';

class AvailableRides extends StatelessWidget {
  final String driverName = "Mohamed";
  const AvailableRides({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: gray0,
      ),
      height: 70.rh,
      margin: EdgeInsets.symmetric(vertical: 7.rh),
      padding: EdgeInsets.only(
        top: 13.rh,
        bottom: 13.rh,
        left: 10.rw,
        right: 44.rw,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BookRidePage();
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          spacing: 50,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/car.png"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uber Pool",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      // ignore: unnecessary_string_interpolations
                      "$driverName",
                      style: TextStyle(color: gray2, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("200", style: TextStyle(color: green, fontSize: 16)),
                Transform.translate(
                  offset: Offset(0, -4), // ✅ Moves text up
                  child: Text(
                    "EGP",
                    style: TextStyle(color: green, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
