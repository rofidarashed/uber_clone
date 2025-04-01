import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
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
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: black, 
          selectionColor: gray1, 
          selectionHandleColor: black, 
        ),
      ),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Uber',

      home: const IntroPage(),
    );
  }
}
