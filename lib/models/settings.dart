import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../shared/enums.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings{
  static const String themeTypeName = 'themeType';

  factory Settings({
    @JsonKey(name: 'theme_type') required SudokuThemeType themeType,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

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
