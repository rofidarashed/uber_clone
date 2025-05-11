import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/elements/buttons/input_text_button.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: white),
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.rw),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot password ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              Text(
                "Please enter your email to reset the\npassword ",
                style: TextStyle(fontSize: 18),
                maxLines: 2,
              ),
              SizedBox(height: 122.rh),
              InputTextButton(
                labelText: 'Enter your e-mail',
                hintText: 'qwerty@gmail.com',
                controller: _email,
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
              SizedBox(height: 4.rh),
              BlackButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                 try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _email.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please check your email to reset your password',
                        ),
                      ),
                    );
                 } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-credential') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Wrong email.")),
                          );
                          return;
                        }
                      }
                  }
                },
                label: 'Reset Password  ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
