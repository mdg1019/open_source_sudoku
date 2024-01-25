import 'dart:math';
import 'package:sudoku/models/settings.dart';

import '../themes/sudoku_theme.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';
import 'difficulty_levels.dart';
import 'location.dart';

class Utils {
  
  static int getBoxNumber(int row, int col) {
    return (row ~/ 3) * 3 + (col ~/ 3);
  }

  static int getGivens(String levelName) {
    DifficultyLevel difficultyLevel = DifficultyLevels.difficultyLevels.firstWhere((difficultyLevel) => difficultyLevel.name == levelName);

    return Random().nextInt(difficultyLevel.high - difficultyLevel.low + 1) + difficultyLevel.low;
  }

  static SudokuTheme getTheme(SudokuThemeType themeType) {
    switch (themeType) {
      case SudokuThemeType.light:
        return LightTheme();
      default:
        return DarkTheme();
    }
  }
  
  static bool isInSameBox(Location location, int row, int col) {
    return getBoxNumber(location.row, location.col) == getBoxNumber(row, col);
  }
}
