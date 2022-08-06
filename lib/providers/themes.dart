import 'package:flutter/material.dart';

class ThemesProvider extends ChangeNotifier {
  bool darkModeOn = false;

  void darkModeChanger() {
    darkModeOn = !darkModeOn;
    notifyListeners();
  }
}
//ThemeData.primaryColorLight

class ThemeOptions {
  static final black = ThemeData(
      primaryColorDark: Colors.white,
      backgroundColor: const Color.fromARGB(255, 83, 83, 83),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Color.fromARGB(255, 83, 83, 83),
      ));

  static final white = ThemeData(
      colorScheme: const ColorScheme.light(onPrimary: Colors.white),
      backgroundColor: Color.fromARGB(255, 176, 176, 176));
}
