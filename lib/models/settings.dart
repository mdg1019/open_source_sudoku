import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.g.dart';

enum SudokuThemeType { light, dark }

class Settings {
  final SudokuThemeType themeType;

  Settings({required this.themeType});
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  SharedPreferences? sharedPreferences;

  @override
  FutureOr<Settings> build() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final themeType = SudokuThemeType.values[sharedPreferences!.getInt('theme') ??
              SudokuThemeType.light.index];
    return Settings(themeType: themeType);
  }

  void toggleTheme() {
    final themeType = (state.value?.themeType == SudokuThemeType.light)
        ? SudokuThemeType.dark
        : SudokuThemeType.light;
    sharedPreferences!.setInt('themeType', themeType.index);
    state = AsyncValue.data(Settings(themeType: themeType));
  }
}