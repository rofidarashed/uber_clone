import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/widgets/Intro_login_button.dart';
import 'package:uber/widgets/divider_widget.dart';
import 'package:uber/widgets/intro_create_account_button.dart';
import 'package:uber/widgets/social_login_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8,
            top: MediaQuery.of(context).size.height / 5,
            bottom: MediaQuery.of(context).size.height / 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 100,
                child: Image.asset(
                  "assets/logoDark.png",
                  width: double.minPositive,
                ),
              ),
              Text('Your next ride.', style: TextStyle(fontSize: 20)),
              Spacer(flex: 1),
              IntroLoginButton(),
              IntroCreateAccountButton(),
              DividerWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialLoginButton(image: 'assets/facebook.png', onPress: () {  },),
                  SocialLoginButton(image: 'assets/google.png', onPress: () {  },),
                  SocialLoginButton(image: 'assets/apple.png', onPress: () {  },),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
