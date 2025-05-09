import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/services/sp_service.dart';
import 'package:uber/elements/widgets/recent_rides.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/pages/account_page.dart';

class HomePage extends StatelessWidget {
  final List<String> salary = [
    '90',
    '95',
    '100',
    '110',
    '125',
    '150',
    '160',
    '175',
    '190',
    '200',
  ];
  final List<String> date = [
    '29, March',
    '25, March',
    '23, March',
    '21, March',
    '20, March',
    '20, March',
    '16, March',
    '15, March',
    '13, March',
    '10, March',
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final displayName = SpService.i.prefs?.getString("displayName");
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
                    "Welcome Back,\n${displayName ?? "User"}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AccountPage();
                          },
                        ),
                      );
                    },
                    icon: Image.asset(
                      "assets/profile.png",
                      fit: BoxFit.cover,
                      height: 40.rh,
                    ),
                  ),
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
                  return RecentRides(salary: salary[index], date: date[index]);
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
