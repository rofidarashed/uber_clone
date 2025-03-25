import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/pages/main_page.dart';
import 'package:uber/widgets/create_an_account_button.dart';
import 'package:uber/widgets/input_text_button.dart';

class CreateAnAccountPage extends StatelessWidget {
  CreateAnAccountPage({super.key});

  final _formKey = GlobalKey<FormState>();

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
                  CreateAnAccountButton(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MainPage();
                            },
                          ),
                        );
                      }
                    },
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
                  validator: (String? email) {
                    if (email!.isEmpty == true) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(email)) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                  obscureText: false,
                ),
                InputTextButton(
                  labelText: 'Password',
                  hintText: '*****',
                  controller: _passwordController,
                  validator: (password) {
                    if (password!.isEmpty == true) {
                      return 'Please enter your password';
                    } else if (password.length < 5) {
                      return 'Password must be 5 characters or more';
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
