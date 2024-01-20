import 'package:flutter/material.dart';
import '../interfaces/sudoku_theme.dart';

class LightTheme implements SudokuTheme {
  static final LightTheme _instance = LightTheme._internal();

  factory LightTheme() {
    return _instance;
  }

  LightTheme._internal();

  @override
  Color gridBoxBorderColor = Colors.grey[850]!;

  @override
  Color gridInnerBorderColor = Colors.grey[200]!;

  @override
  IconData appBarThemeIcon = Icons.dark_mode;

  @override
  ThemeData theme = ThemeData(
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