import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/services/sp_service.dart';
import 'package:uber/firebase_options.dart';
import 'package:uber/globals.dart';
import 'package:uber/pages/intro_page.dart';
import 'package:uber/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SpService.i.init();
  if (!SpService.i.prefs!.containsKey("balance")) {
    await SpService.i.prefs!.setInt("balance", 0);
  }
  runApp(const MyApp());
}

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

      home:
          (FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified)
              ? MainPage()
              : const IntroPage(),
    );
  }
}
