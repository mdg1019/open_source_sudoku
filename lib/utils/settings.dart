import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/utils/shared.dart';

class Settings {
  SudokuTheme? theme;

  Settings._() {
    get();
  }

  static final Settings _instance = Settings._();

  static Settings get instance => _instance;

  Settings get() {
    bool isDirty = false;

    (() async {
      var prefs = await SharedPreferences.getInstance();
      theme = prefs.getInt('theme') as SudokuTheme?;

      if (theme == null) {
        theme = SudokuTheme.light;
        isDirty = true;
      }
    })();

    return this;
  }

  void save() {
    (() async {
      var prefs = await SharedPreferences.getInstance();

      await prefs.setInt('theme', theme as int);
    })();
  }
}