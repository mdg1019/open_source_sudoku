import 'package:flutter/material.dart';

abstract class SudokuTheme {
  Color gridBoxBorderColor;
  Color gridInnerBorderColor;
  IconData appBarThemeIcon;
  ThemeData theme;

  SudokuTheme ({
    required this.gridBoxBorderColor,
    required this.gridInnerBorderColor,
    required this.appBarThemeIcon,
    required this.theme,
  });
}