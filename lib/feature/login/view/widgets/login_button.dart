import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/feature/home/view/screens/main_page.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _formKey = formKey,
       _emailController = emailController,
       _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: MediaQuery.of(context).size.width / 8,
      ),
      child: BlackButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
              if (credential.user!.emailVerified) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MainPage();
                    },
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Durations.medium4,
                    content: Text('Please verify your email first')),
                );
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'invalid-credential') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: red,
                    duration: Durations.medium4,
                    content: Text("Wrong password or email.")),
                );
                return;
              }
            }
          }
        },
        label: "Login",
      ),
    );
  }
}
