import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../shared/enums.dart';
import '../shared/utils.dart';

part 'settings.g.dart';

class Settings {
  final SudokuThemeType themeType;

  Settings({required this.themeType});

  Settings.fromJson(Map<String, dynamic> json)
      : themeType = SudokuThemeType.values[json['themeType']];

  Map<String, dynamic> toJson() => { 'themeType': themeType.index };

  static Future<Settings> getSettings() async {
    return Utils.getJson('settings.json', (json) => Settings.fromJson(json), Settings(themeType: SudokuThemeType.light));
  }

  static Future<void> saveSettings(Settings settings) async {
    await Utils.saveJson(settings, 'settings.json');
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
