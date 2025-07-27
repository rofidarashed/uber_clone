import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/login/view/widgets/forgot_password.dart';
import 'package:uber/feature/login/view/widgets/login_button.dart';
import 'package:uber/core/widgets/input_text_button.dart';

class LoginPage extends StatefulWidget {
  final String? password;

  const LoginPage({super.key, this.password});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 8,
                      right: MediaQuery.of(context).size.width / 8,
                      top: MediaQuery.of(context).size.height / 20,
                      bottom: MediaQuery.of(context).size.height / 15,
                    ),
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
                        Text(
                          'Login to your account.',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .062,
                        ),
                        InputTextButton(
                          labelText: 'E-mail',
                          hintText: 'qwerty@gmail.com',
                          controller: _emailController,
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
                            } else if (password.length < 6) {
                              return 'Password must be 6 characters or more';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        ForgotPassword(),
                      ],
                    ),
                  ),
                ),
              ),
              LoginButton(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
