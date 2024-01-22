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
  TextStyle currentValueTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  @override
  TextStyle appBarThemeTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  @override
  ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
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

  @override
  Color cursorLocationBackgroundColor = Colors.grey[700]!;

  @override
  Color backgroundColor = Colors.black;

  @override
  Color highlightBackgroundColor = Colors.grey[600]!;

  @override
  TextStyle difficultyTextStyle = const TextStyle(
    fontSize: 12.0,
  );

  @override
  TextStyle mistakesTextStyle = const TextStyle(
    fontSize: 12.0,
  );

  @override
  Color splashColor = Colors.grey[700]!;

  @override
  TextStyle wrongValueTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 20.0,
  );

  @override
  Color wrongValueBackgroundColor = Colors.red[100]!;
}