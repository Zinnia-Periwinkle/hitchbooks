// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Colors.white;
const secondaryColor = Colors.grey;

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.dark;
    notifyListeners();
  }
}

class Themes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      colorScheme: ColorScheme.dark(),
      iconTheme: IconThemeData(
          color: Color(
            0xFFb24c63,
          ),
          opacity: 0.8));
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Color(0xFF52b788), opacity: 0.8));
}
