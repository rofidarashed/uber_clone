import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/Intro/view/intro_page.dart';
import 'package:uber/feature/account/view/screens/add_amount_page.dart';
import 'package:uber/feature/account/view/widgets/account_header.dart';
import 'package:uber/core/elements/size_extensions.dart';
import 'package:uber/feature/account/view/screens/profile_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 20.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountHeader(),
            SizedBox(height: 30.rh),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Profile',
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 18.rh),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddAmountPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Top-up balance',
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.rh),
                    child: Divider(thickness: 1.3),
                  ),
                  InkWell(
                    onTap: () async {
                      final googleSignIn = GoogleSignIn();

                      if (await googleSignIn.isSignedIn()) {
                        await googleSignIn.signOut();
                      }
                      await FirebaseAuth.instance.signOut();

                      await Future.delayed(const Duration(milliseconds: 500));
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return const IntroPage();
                          },
                        ),
                        (Route) => false,
                      );
                    },
                    child: Text(
                      "Log out",
                      style: TextStyle(color: red, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
