import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/widgets/input_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: white),
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8,
            top: MediaQuery.of(context).size.height / 5,
            bottom: MediaQuery.of(context).size.height / 15,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width*0.82587,
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
                Text('Login to your account.', style: TextStyle(fontSize: 20)),
                Spacer(flex: 2),
                InputTextButton(
                  labelText: 'E-mail',
                  hintText: 'qwerty@gmail.com',
                ),
                InputTextButton(labelText: 'Password', hintText: '*****'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(color: black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
