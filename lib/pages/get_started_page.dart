import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/components/get_started_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset(
                "assets/logoDark.png",
                width: double.minPositive,
              ),
            ),
            Spacer(flex: 1),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: gray,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'move with safety',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Spacer(flex: 3),
            GetStartedButton(),
          ],
        ),
      ),
    );
  }
}
