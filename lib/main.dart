import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/elements/firebase_options.dart';
import 'package:uber/core/services/sp_service.dart';
import 'package:uber/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SpService.i.init();
  if (!SpService.i.prefs!.containsKey("balance")) {
    await SpService.i.prefs!.setInt("balance", 0);
  }
  runApp(const MyApp());
}

