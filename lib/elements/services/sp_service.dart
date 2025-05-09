import 'package:shared_preferences/shared_preferences.dart';

class SpService {
  SharedPreferences? prefs;

  static final _instance = SpService._();
  static SpService get instance => _instance;
  static SpService get i => _instance;

  SpService._();

  Future<void> init() async {
    print("intializing sp");
    prefs = await SharedPreferences.getInstance();
    print("prefs => $prefs");
  }
}
