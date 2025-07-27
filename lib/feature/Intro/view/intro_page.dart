import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/core/services/google_auth_service.dart';
import 'package:uber/core/services/sp_service.dart';
import 'package:uber/feature/Intro/view/widgets/or_divider_widget.dart';
import 'package:uber/feature/Intro/view/widgets/intro_create_account_button.dart';
import 'package:uber/feature/Intro/view/widgets/social_login_button.dart';
import 'package:uber/feature/login/view/screens/login_page.dart';
import 'package:uber/feature/home/view/screens/navigator_page.dart';

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
                height: MediaQuery.of(context).size.height * 0.132,
                child: Image.asset(
                  "assets/logoDark.png",
                  width: double.minPositive,
                ),
              ),
              Text('Your next ride.', style: TextStyle(fontSize: 20)),
              Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: BlackButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  label: 'Login to your account',
                ),
              ),
              IntroCreateAccountButton(),
              OrDividerWidget(),
              SocialLoginButton(
                image: 'assets/google.png',
                onPress: () async {
                  UserCredential? userCredential =
                      await GoogleAuthService.signInWithGoogle();
                  final user = userCredential?.user;
                  await SpService.i.prefs?.setString(
                    "displayName",
                    user?.displayName ?? "",
                  );
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MainPage();
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
