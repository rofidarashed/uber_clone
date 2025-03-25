import 'package:flutter/material.dart';
import 'package:uber/globals.dart';
import 'package:uber/pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Uber',

      home: const IntroPage(),
    );
  }
}
