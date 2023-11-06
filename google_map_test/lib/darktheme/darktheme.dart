
import 'package:flutter/material.dart';

extension DarkMode on BuildContext{
  bool get isDarkMode {
    final brihtness = MediaQuery.of(this).platformBrightness;
    return brihtness == Brightness.dark;
  }
}