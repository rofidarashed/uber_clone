import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/feature/login/view/screens/login_page.dart';
import 'package:uber/feature/home/view/screens/navigator_page.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
  }) : _formKey = formKey, _emailController = emailController, _passwordController = passwordController, _nameController = nameController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 26,
        horizontal: MediaQuery.of(context).size.width / 8,
      ),
      child: BlackButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            try {
              var userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
    
              await userCredential.user!.updateDisplayName(
                _nameController.text,
              );
    
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .set({
                    'email': _emailController.text,
                    'balance': 0,
                    'createdAt': FieldValue.serverTimestamp(),
                  });
    
              await userCredential.user!.sendEmailVerification();
              FirebaseAuth.instance.currentUser!.emailVerified
                  ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  )
                  : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Durations.medium4,
                      content: Text(
                        'Please check your email to verify your account. ',
                      ),
                    ),
                  );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'email-already-in-use') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      duration: Durations.medium4,
                      backgroundColor: green,
                    content: Text(
                      'An account already exists for that email.\nNow you can login easily :)',
                    ),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                      duration: Durations.medium4,
                      backgroundColor: red,
                  content: Text(
                    'An error occurred. Please try again.',
                  ),
                ),
              );
            }
          }
        },
    
        label: "Create an account",
      ),
    );
  }
}
