import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
