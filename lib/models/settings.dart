import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.g.dart';

enum SudokuTheme { light, dark }

class Settings {
  final SudokuTheme theme;

  Settings({required this.theme});
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  SharedPreferences? sharedPreferences;

  @override
  FutureOr<Settings> build() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final theme = SudokuTheme.values[sharedPreferences!.getInt('theme') ??
              SudokuTheme.light.index];
    return Settings(theme: theme);
  }

  void toggleTheme() {
    final theme = (state.value?.theme == SudokuTheme.light)
        ? SudokuTheme.dark
        : SudokuTheme.light;
    sharedPreferences!.setInt('theme', theme.index);
    state = AsyncValue.data(Settings(theme: theme));
  }
}