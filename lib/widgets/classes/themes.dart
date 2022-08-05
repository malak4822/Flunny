import 'package:flutter/material.dart';

class ThemesProvider extends ChangeNotifier {
  bool darkModeOn = false;

  void darkModeChanger() {
    darkModeOn = !darkModeOn;
    notifyListeners();
  }
}

class ThemeOptions {
  static final black =
      ThemeData(splashColor: Colors.green, colorScheme: ColorScheme.dark());

  static final white =
      ThemeData(splashColor: Colors.red, colorScheme: ColorScheme.light());
}
