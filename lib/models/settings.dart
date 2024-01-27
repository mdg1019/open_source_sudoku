import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../shared/enums.dart';

part 'settings.g.dart';

class Settings {
  final SudokuThemeType themeType;

  Settings({required this.themeType});

  Settings.fromJson(Map<String, dynamic> json)
      : themeType = SudokuThemeType.values[json['themeType']];

  Map<String, dynamic> toJson() => { 'themeType': themeType.index };

  static Future<Settings> getSettings() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = '${documentsDirectory.path}/settings.json';
    final File file = File(path);

    if (await file.exists()) {
      return Settings.fromJson(jsonDecode(await file.readAsString()));
    }

    final Settings settings = Settings(themeType: SudokuThemeType.light);

    await file.writeAsString(jsonEncode(settings.toJson()));

    return settings;
  }

  static Future<void> saveSettings(Settings settings) async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = '${documentsDirectory.path}/settings.json';
    final File file = File(path);

    await file.writeAsString(jsonEncode(settings.toJson()));
  }
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  FutureOr<Settings> build() async {
    return await Settings.getSettings();
  }

  @override
  bool updateShouldNotify(AsyncValue<Settings> previous, AsyncValue<Settings> next) {

    (() async {
      await Settings.saveSettings(next.value!);
    })();

    return true;
  }

  void toggleTheme() {
    final newThemeType = (state.value?.themeType == SudokuThemeType.light)
        ? SudokuThemeType.dark
        : SudokuThemeType.light;

    state = AsyncValue.data(Settings(themeType: newThemeType));
  }
}
