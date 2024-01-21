import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/constants/difficulty_levels.dart';

part 'settings.g.dart';

enum SudokuThemeType { light, dark }

class Settings {
  final SudokuThemeType themeType;
  final String difficultyLevel;

  static const String themeTypeName = 'themeType';
  static const String difficultyLevelName = 'difficultyLevel';

  Settings({required this.themeType, required this.difficultyLevel});
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  SharedPreferences? sharedPreferences;

  @override
  FutureOr<Settings> build() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final themeType =
        SudokuThemeType.values[sharedPreferences!.getInt(Settings.themeTypeName) ??
            (() {
              sharedPreferences!
                  .setInt(Settings.themeTypeName, SudokuThemeType.light.index);
              return SudokuThemeType.light.index;
            })()];
    final difficultyLevel = sharedPreferences!.getString(Settings.difficultyLevelName) ??
        (() {
          sharedPreferences!.setString(Settings.difficultyLevelName, DifficultyLevel.easy);
          return DifficultyLevel.easy;
        })();
    return Settings(themeType: themeType, difficultyLevel: difficultyLevel);
  }

  void toggleTheme() {
    final themeType = (state.value?.themeType == SudokuThemeType.light)
        ? SudokuThemeType.dark
        : SudokuThemeType.light;
    sharedPreferences!.setInt('themeType', themeType.index);
    state = AsyncValue.data(Settings(
        themeType: themeType, difficultyLevel: state.value!.difficultyLevel));
  }
}
