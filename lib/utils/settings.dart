import 'package:synchronized/synchronized.dart';
import 'package:sudoku/utils/shared.dart';

class Settings {
  SudokuTheme theme = SudokuTheme.light;

  Settings._();

  static final Settings _instance = Settings._();

  static final _lock = Lock();

  static Future<Settings> get instance {
    return _lock.synchronized(() {
      return _instance;
    });
  }
}