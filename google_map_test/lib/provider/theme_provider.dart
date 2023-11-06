import 'package:flutter/material.dart';

class ThemeChange with ChangeNotifier {
  var _themeMode = ThemeMode.light;
  ThemeMode get getThemeMode => _themeMode;

  void setTheme( themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
