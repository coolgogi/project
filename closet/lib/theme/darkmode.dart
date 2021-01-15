import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
    // brightness: Brightness.light,
    brightness: Brightness.light,
    // primaryColorLight: Color(0xff6200EE),
    primarySwatch: Colors.indigo,
    accentColor: Colors.pink,
    scaffoldBackgroundColor: Color(0xfff1f1f1));
// scaffoldBackgroundColor: Color(0xff6200EE));

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    accentColor: Colors.pink,
    scaffoldBackgroundColor: Color(0xfff1f1f1));

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _pref;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;
  ThemeNotifier() {
    _darkTheme = false;
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}
