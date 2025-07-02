import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/widgets/input_text_button.dart';

class BuildForm extends StatelessWidget {
  const BuildForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController nameController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) : _formKey = formKey, _emailController = emailController, _nameController = nameController, _passwordController = passwordController, _confirmPasswordController = confirmPasswordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _nameController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
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
                  labelText: 'UserName',
                  hintText: 'user name',
                  controller: _nameController,
                  validator: (String? name) {
                    if (name!.isEmpty == true) {
                      return 'Please enter your name';
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
