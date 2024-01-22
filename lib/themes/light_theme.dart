import 'package:flutter/material.dart';
import '../interfaces/sudoku_theme.dart';

class LightTheme implements SudokuTheme {
  static final LightTheme _instance = LightTheme._internal();

  factory LightTheme() {
    return _instance;
  }

  LightTheme._internal();

  @override
  Color gridBoxBorderColor = Colors.grey[900]!;

  @override
  Color gridInnerBorderColor = Colors.grey[400]!;

  @override
  IconData appBarThemeIcon = Icons.dark_mode;

  @override
  TextStyle currentValueTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20.0,
  );

  @override
  TextStyle appBarThemeTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

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

  @override
  Color cursorLocationBackgroundColor = Colors.grey[300]!;

  @override
  Color backgroundColor = Colors.white;

  @override
  Color highlightBackgroundColor = Colors.grey[100]!;

  @override
  TextStyle difficultyTextStyle = const TextStyle(
    fontSize: 12.0,
  );

  @override
  TextStyle mistakesTextStyle = const TextStyle(
    fontSize: 12.0,
  );

  @override
  Color splashColor = Colors.grey[300]!;

  @override
  TextStyle wrongValueTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 20.0,
  );

  @override
  Color wrongValueBackgroundColor = Colors.red[100]!;

  @override
  Color notesBackgroundColor = Colors.purple[100]!;

  @override
  TextStyle notesTextStyle = TextStyle(
    color: Colors.purple[300]!,
    fontSize: 8.0,
  );

  @override
  Color notesIconColor = Colors.purple[300]!;
}