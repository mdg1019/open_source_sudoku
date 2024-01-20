import 'package:flutter/material.dart';
import '../interfaces/sudoku_theme.dart';

class DarkTheme implements SudokuTheme {
  static final DarkTheme _instance = DarkTheme._internal();

  factory DarkTheme() {
    return _instance;
  }

  DarkTheme._internal();

  @override
  Color gridBoxBorderColor = Colors.grey[50]!;

  @override
  Color gridInnerBorderColor = Colors.grey[200]!;

  @override
  IconData appBarThemeIcon = Icons.light_mode;

  @override
  ThemeData theme = ThemeData(
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