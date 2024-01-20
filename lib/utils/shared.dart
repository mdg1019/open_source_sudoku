import 'package:sudoku/models/settings.dart';

import '../interfaces/sudoku_theme.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';

typedef Puzzle = List<List<int>>;

class Location {
  final int row;
  final int column;

  Location(this.row, this.column);
}

class GeneratedPuzzle {
  final Puzzle starting;
  final Puzzle solution;

  GeneratedPuzzle(this.starting, this.solution);
}

class Shared {
  static Puzzle copyPuzzle(Puzzle puzzle) {
    Puzzle copy = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(puzzle[r][c]);
      }

      copy.add(row);
    }

    return copy;
  }

  static Puzzle createEmptyPuzzle() {
    Puzzle puzzle = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(0);
      }

      puzzle.add(row);
    }

    return puzzle;
  }

  static bool doesBoxHaveNumber(
      Puzzle puzzle, int row, int column, int number) {
    int r = row - row % 3;
    int c = column - column % 3;

    for (int i = r; i < r + 3; i++) {
      for (int j = c; j < c + 3; j++) {
        if (puzzle[i][j] == number) {
          return true;
        }
      }
    }

    return false;
  }

  static bool doesColumnHaveNumber(Puzzle puzzle, int column, int number) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[i][column] == number) {
        return true;
      }
    }

    return false;
  }

  static bool doesRowHaveNumber(Puzzle puzzle, int row, int number) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[row][i] == number) {
        return true;
      }
    }

    return false;
  }

  static Location? findEmptyCell(Puzzle puzzle) {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (puzzle[r][c] == 0) {
          return Location(r, c);
        }
      }
    }

    return null;
  }

  static SudokuTheme getTheme(SudokuThemeType themeType) {
    switch (themeType) {
      case SudokuThemeType.light:
        return LightTheme();
      default:
        return DarkTheme();
    }
  }

  static bool isSolved(Puzzle puzzle) {
    return findEmptyCell(puzzle) == null;
  }

  static bool isValidPlacement(
      Puzzle puzzle, int row, int column, int number) {
    return !doesRowHaveNumber(puzzle, row, number) &&
        !doesColumnHaveNumber(puzzle, column, number) &&
        !doesBoxHaveNumber(puzzle, row, column, number);
  }

  static Puzzle populatePuzzle(String rawPuzzle) {
    Puzzle puzzle = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(int.parse(rawPuzzle[r * 9 + c]));
      }

      puzzle.add(row);
    }

    return puzzle;
  }

  static String puzzleToString(Puzzle puzzle) {
    String rawPuzzle = "";

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        rawPuzzle += puzzle[r][c].toString();
      }
    }

    return rawPuzzle;
  }
}
