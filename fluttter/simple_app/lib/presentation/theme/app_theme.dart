import 'package:flutter/material.dart';

final ThemeData brightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 14, color: Color(0xFF0A2472)),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFDDDDDD),
    iconTheme: IconThemeData(color: Color(0xFF0A2472)),
    titleTextStyle: TextStyle(color: Color(0xFF0A2472), fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF0A2472),
    secondary: Color(0xFFDDDDDD),
  ),
  iconTheme: const IconThemeData(color: Color(0xFFA68608)),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFB29000), // Set default button color
  ),// Set default icon color
);
