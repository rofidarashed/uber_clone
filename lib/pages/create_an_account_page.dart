import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/pages/login_page.dart';
import 'package:uber/pages/main_page.dart';
import 'package:uber/elements/buttons/input_text_button.dart';

class CreateAnAccountPage extends StatelessWidget {
  CreateAnAccountPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildForm(context),
            Center(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'By creating an account, you agree\nto our Terms of Service and Privacy Policy.',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 26,
                      horizontal: MediaQuery.of(context).size.width / 8,
                    ),
                    child: BlackButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            // final credential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            FirebaseAuth.instance.currentUser!.emailVerified
                                ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please check your email to verify your account. ',
                                    ),
                                  ),
                                );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildForm(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8,
            top: MediaQuery.of(context).size.height / 20,
            bottom: MediaQuery.of(context).size.height / 15,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height * 0.132,
                  child: Image.asset(
                    "assets/logoDark.png",
                    width: double.minPositive,
                  ),
                ),
                Text('Create an account.', style: TextStyle(fontSize: 20)),
                SizedBox(height: MediaQuery.of(context).size.height * .062),
                InputTextButton(
                  labelText: 'E-mail',
                  hintText: 'qwerty@gmail.com',
                  controller: _emailController,
                  validator: (String? email) {
                    if (email!.isEmpty == true) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(email)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  obscureText: false,
                ),
                InputTextButton(
                  labelText: 'Password',
                  hintText: '******',
                  controller: _passwordController,
                  validator: (password) {
                    if (password!.isEmpty == true) {
                      return 'Please enter your password';
                    } else if (password.length < 6) {
                      return 'Password is weak ,use at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                InputTextButton(
                  labelText: 'Repeat Password',
                  hintText: '*****',
                  controller: _confirmPasswordController,
                  validator: (confirmPassword) {
                    if (confirmPassword!.isEmpty == true) {
                      return 'Please enter your password';
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return 'Passwords must be the same';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
