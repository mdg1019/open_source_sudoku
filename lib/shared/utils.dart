import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

import '../models/settings.dart';
import '../themes/sudoku_theme.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';
import 'difficulty_levels.dart';
import 'enums.dart';
import 'location.dart';

class Utils {
  static int getBoxNumber(int row, int col) {
    return (row ~/ 3) * 3 + (col ~/ 3);
  }

  static int getGivens(String levelName) {
    DifficultyLevel difficultyLevel = DifficultyLevels.difficultyLevels.firstWhere((difficultyLevel) => difficultyLevel.name == levelName);

    return Random().nextInt(difficultyLevel.high - difficultyLevel.low + 1) + difficultyLevel.low;
  }
  static Future<T> getJson<T>(String filename, T Function(Map<String, dynamic> json) fromJson, T defaultValue) async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = '${documentsDirectory.path}/$filename';
    final File file = File(path);

    if (await file.exists()) {
      return fromJson(jsonDecode(await file.readAsString()));
    }

    await file.writeAsString(jsonEncode(defaultValue));

    return defaultValue;
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

  static Future<void> saveJson<T>(Map<String, dynamic> json, String filename) async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = '${documentsDirectory.path}/$filename';
    final File file = File(path);

    await file.writeAsString(jsonEncode(json));
  }
}
