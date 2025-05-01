import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/elements/services/google_auth_service.dart';
import 'package:uber/elements/widgets/or_divider_widget.dart';
import 'package:uber/elements/buttons/intro_create_account_button.dart';
import 'package:uber/elements/buttons/social_login_button.dart';
import 'package:uber/pages/login_page.dart';
import 'package:uber/pages/main_page.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialLoginButton(
                    image: 'assets/facebook.png',
                    onPress: () async {
                      await GoogleSignIn().signOut();
                    },
                  ),
                  SocialLoginButton(
                    image: 'assets/google.png',
                    onPress: () async {
                      UserCredential? user =
                          await GoogleAuthService.signInWithGoogle();
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
                  SocialLoginButton(image: 'assets/apple.png', onPress: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
