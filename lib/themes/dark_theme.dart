import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme:  const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'Lato',
        ),
      ),
      fontFamily: 'Lato',
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(background: Colors.black),
    );
  }
}