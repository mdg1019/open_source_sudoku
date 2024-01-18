import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/utils/shared.dart';

class Settings {
  final SudokuTheme theme;

  Settings({required this.theme});
}

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((_) async => await SharedPreferences.getInstance());

class SettingsNotifier extends StateNotifier<Settings> {
  SharedPreferences? sharedPreferencesInstance;
  Settings settings = Settings(theme: SudokuTheme.light);

  SettingsNotifier(this.settings)  : super(settings) {
    (() async {
      sharedPreferencesInstance = await SharedPreferences.getInstance();
    })();
  }

  static final provider = StateNotifierProvider<SettingsNotifier, Settings>((ref) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider).maybeWhen(
        data: (sharedPreferences) => sharedPreferences,
        orElse: () => null,
    );

    if (sharedPreferences == null) {
      return SettingsNotifier(Settings(theme: SudokuTheme.light));
    }

    int theme = sharedPreferences.getInt('theme') ?? SudokuTheme.light.index;

    Settings settings = Settings(
      theme: SudokuTheme.values[theme],
    );

    return SettingsNotifier(settings);
  });

  void toggleTheme() {
    SudokuTheme newTheme = (state.theme == SudokuTheme.light) ? SudokuTheme.dark : SudokuTheme.light;
    state = Settings(theme: newTheme);

    sharedPreferencesInstance?.setInt('theme', state.theme.index);
  }
}
