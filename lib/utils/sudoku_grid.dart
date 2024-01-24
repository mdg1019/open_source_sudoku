

import 'package:sudoku/utils/shared.dart';

import '../models/sudoku.dart';

class SudokuGrid<T> {
  late List<List<T>> _grid;
  final bool Function(T, int) haveNumber;

  SudokuGrid(this._grid, this.haveNumber);

  SudokuGrid.fromList(List<T> list, this.haveNumber) {
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

  SudokuGrid<T> copy() {
    List<List<T>> gridCopy = [];

    for (int r = 0; r < 9; r++) {
      List<T> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(this[r][c]);
      }

      gridCopy.add(row);
    }

    return SudokuGrid(gridCopy, haveNumber);
  }

  bool doesBoxHaveNumber(int row, int column, int number) {
    int r = row - row % 3;
    int c = column - column % 3;

    for (int i = r; i < r + 3; i++) {
      for (int j = c; j < c + 3; j++) {
        if (haveNumber(_grid[i][j], number)) {
          return true;
        }
      }
    }

    return false;
  }

  bool doesColumnHaveNumber(int column, int number) {
    for (int i = 0; i < 9; i++) {
      if (haveNumber(_grid[i][column], number)) {
        return true;
      }
    }

    return false;
  }

  bool doesRowHaveNumber(int row, int number) {
    for (int i = 0; i < 9; i++) {
      if (haveNumber(_grid[row][i], number)) {
        return true;
      }
    }

    return false;
  }

  Location? findEmptyCell() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (haveNumber(_grid[r][c], 0)) {
          return Location(r, c);
        }
      }
    }

    return null;
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
}

class DisplayGrid extends SudokuGrid<PuzzleCell> {
  static bool _predicate(PuzzleCell a, int b) {
    return  a.current == b;
  }

  DisplayGrid(List<List<PuzzleCell>> grid) : super(grid, _predicate);

  DisplayGrid.fromSudokuNumericGrid(NumericGrid grid) : super(grid._grid.map((row) => row.map((e) => PuzzleCell(current: e, solution: e)).toList()).toList(), _predicate);
}