import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/widgets/recent_rides.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 20.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome Back,\nAfaf",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  CircleAvatar(child: Image.asset("assets/profile.png")),
                ],
              ),
            ),
            SizedBox(height: 47.rh),
            Text(
              "  Recent rides",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return RecentRides();
                },
              ),
            ),
            SizedBox(height: 45.rh),
          ],
        ),
      ),
    );
  }
}
