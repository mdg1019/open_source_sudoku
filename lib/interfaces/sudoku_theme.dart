import 'package:flutter/material.dart';

abstract class SudokuTheme {
  Color backgroundColor;
  Color cursorLocationBackgroundColor;
  Color gridBoxBorderColor;
  Color gridInnerBorderColor;
  Color highlightBackgroundColor;
  IconData appBarThemeIcon;
  TextStyle appBarThemeTextStyle;
  TextStyle currentValueTextStyle;
  TextStyle difficultyTextStyle;
  ThemeData theme;

  SudokuTheme ({
    required this.gridBoxBorderColor,
    required this.gridInnerBorderColor,
    required this.appBarThemeIcon,
    required this.currentValueTextStyle,
    required this.appBarThemeTextStyle,
    required this.theme,
    required this.cursorLocationBackgroundColor,
    required this.backgroundColor,
    required this.highlightBackgroundColor,
    required this.difficultyTextStyle,
  });
}