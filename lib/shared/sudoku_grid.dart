import 'dart:math';

import 'package:sudoku/shared/utils.dart';
import '../models/sudoku.dart';

class SudokuGrid<T> {
  late List<List<T>> _grid;
  late bool Function(T, int) hasNumber;

  SudokuGrid(this._grid, this.hasNumber);

  SudokuGrid.fromList(List<T> list, this.hasNumber) {
    List<List<T>> grid = [];
    int count = 0;

    for (int r = 0; r < 9; r++) {
      List<T> row = [];
      for (int c = 0; c < 9; c++) {
        row.add(list[count++]);
      }

      grid.add(row);
    }

    _grid = grid;
  }

  List<T> operator [](int row) {
    return _grid[row];
  }

  bool doesBoxHaveNumber(int row, int column, int number) {
    int r = row - row % 3;
    int c = column - column % 3;

    for (int i = r; i < r + 3; i++) {
      for (int j = c; j < c + 3; j++) {
        if (hasNumber(_grid[i][j], number)) {
          return true;
        }
      }
    }

    return false;
  }

  bool doesColumnHaveNumber(int column, int number) {
    for (int i = 0; i < 9; i++) {
      if (hasNumber(_grid[i][column], number)) {
        return true;
      }
    }

    return false;
  }

  bool doesRowHaveNumber(int row, int number) {
    for (int i = 0; i < 9; i++) {
      if (hasNumber(_grid[row][i], number)) {
        return true;
      }
    }

    return false;
  }

  Location? findEmptyCell() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (hasNumber(_grid[r][c], 0)) {
          return Location(r, c);
        }
      }
    }

    return null;
  }

  bool isSolved() {
    return findEmptyCell() == null;
  }

  bool isValidPlacement(int row, int column, int number) {
    return !doesRowHaveNumber(row, number) &&
        !doesColumnHaveNumber(column, number) &&
        !doesBoxHaveNumber(row, column, number);
  }
}

class NumericGrid extends SudokuGrid<int> {
  static bool _predicate(int a, int b) {
    return a == b;
  }

  NumericGrid(List<List<int>> grid) : super(grid, _predicate);

  NumericGrid.empty() : super(List.generate(9, (_) => List.generate(9, (_) => 0)), _predicate);

  NumericGrid.fromString(String puzzle) : super.fromList(puzzle.split('').map((e) => int.parse(e)).toList(), _predicate);

  NumericGrid copy() {
    NumericGrid copy = NumericGrid.empty();

    for (int r = 0; r < 9; r++) {

      for (int c = 0; c < 9; c++) {
        copy[r][c] = this[r][c];
      }
    }

    return copy;
  }

  solvePuzzle() async {
    if (isSolved()) {
      return true;
    }

    Location? emptyCell = findEmptyCell()!;

    for (int number = 1; number <= 9; number++) {
      if (isValidPlacement(emptyCell.row, emptyCell.col, number)) {
        this[emptyCell.row][emptyCell.col] = number;

        if (await solvePuzzle()) {
          return true;
        }

        this[emptyCell.row][emptyCell.col] = 0;
      }
    }

    return false;
  }

  static Future<GeneratedPuzzle> generatePuzzle(int givens) async {
    while (true) {
      NumericGrid puzzle = NumericGrid.empty();
      puzzle.fillDiagonalBoxes();

      if (await puzzle.solvePuzzle()) {
        return puzzle.removeDigits(givens);
      }
    }
  }

  void fillDiagonalBoxes() {
    for (int i = 0; i < 9; i += 3) {
      fillBox(i, i);
    }
  }

  void fillBox(int row, int column) {
    List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    numbers.shuffle();

    for (int r = row; r < row + 3; r++) {
      for (int c = column; c < column + 3; c++) {
        this[r][c] = numbers.removeLast();
      }
    }
  }

  GeneratedPuzzle removeDigits(int givens) {
    NumericGrid solution = copy();
    Random rng = Random();
    int count = 0;
    int numToRemove = 81 - givens;

    while (count < numToRemove) {
      int row = rng.nextInt(9);
      int column = rng.nextInt(9);

      if (this[row][column] != 0) {
        this[row][column] = 0;
        count++;
      }
    }

    return GeneratedPuzzle(this, solution);
  }
}

class DisplayGrid extends SudokuGrid<PuzzleCell> {
  static bool _predicate(PuzzleCell a, int b) {
    return  a.current == b;
  }

  DisplayGrid(List<List<PuzzleCell>> grid) : super(grid, _predicate);

  DisplayGrid.fromSudokuNumericGrid(GeneratedPuzzle puzzle) : super([], _predicate) {
    for (int r = 0; r < 9; r++) {
      List<PuzzleCell> row = [];

      for (int c = 0; c < 9; c++) {
        PuzzleCell puzzleCell = PuzzleCell(
          starting: puzzle.starting[r][c],
            current: puzzle.starting[r][c],
            solution: puzzle.solution[r][c],
        );

        row.add(puzzleCell);
      }

      _grid.add(row);
    }
  }
}