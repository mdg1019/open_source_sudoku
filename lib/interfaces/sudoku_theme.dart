import 'package:flutter/material.dart';

abstract class SudokuTheme {
  Color gridBoxBorderColor;
  Color gridInnerBorderColor;
  IconData appBarThemeIcon;
  TextStyle currentValueTextStyle;
  TextStyle appBarThemeTextStyle;
  ThemeData theme;

  SudokuTheme ({
    required this.gridBoxBorderColor,
    required this.gridInnerBorderColor,
    required this.appBarThemeIcon,
    required this.currentValueTextStyle,
    required this.appBarThemeTextStyle,
    required this.theme,
  });
}