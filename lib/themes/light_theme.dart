import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme:  const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'Lato',
        ),
      ),
      fontFamily: 'Lato',
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(background: Colors.white),
    );
  }
}