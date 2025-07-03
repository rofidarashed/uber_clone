import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/elements/globals.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/ride/cubit/location_cubit.dart';
import 'package:uber/feature/Intro/view/intro_page.dart';
import 'package:uber/feature/home/view/screens/navigator_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        print('User is signed in!');
      } else {
        print('User is currently signed out!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit(),
      child: MaterialApp(
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

        home:
            (FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified)
                ? MainPage()
                : const IntroPage(),
      ),
    );
  }
}
