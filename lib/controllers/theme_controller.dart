import 'package:flutter/material.dart';
import 'package:recipeapp/themes/themes.dart';

class ThemeController with ChangeNotifier {
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = (_themeData == lightMode) ? darkMode : lightMode;
    themeData = _themeData;
  }
}
