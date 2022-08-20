import 'package:flutter/material.dart';

class ThemesProvider extends ChangeNotifier {
  bool darkModeOn = false;
  bool get dddd {
    return darkModeOn;
  }

  void darkModeChanger() {
    darkModeOn = !darkModeOn;
    notifyListeners();
  }
}
//ThemeData.primaryColorLight

class ThemeOptions {
  static final black = ThemeData(
      appBarTheme:
          const AppBarTheme(backgroundColor: Color.fromARGB(255, 19, 19, 19)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 19, 19, 19)),
      colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 90, 90, 90),
        onPrimary: Colors.white,
      ));

  static final white = ThemeData(
      colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 18, 169, 134), onPrimary: Colors.white),
      backgroundColor: const Color.fromARGB(255, 176, 176, 176));
}
