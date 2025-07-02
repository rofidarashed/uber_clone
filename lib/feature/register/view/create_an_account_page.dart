import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/register/view/widgets/buildform.dart';
import 'package:uber/feature/register/view/widgets/register_button.dart';

class CreateAnAccountPage extends StatefulWidget {
  const CreateAnAccountPage({super.key});

  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
            BuildForm(
              formKey: _formKey,
              emailController: _emailController,
              nameController: _nameController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'By creating an account, you agree\nto our Terms of Service and Privacy Policy.',
                  ),
                  RegisterButton(formKey: _formKey, emailController: _emailController, passwordController: _passwordController, nameController: _nameController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

