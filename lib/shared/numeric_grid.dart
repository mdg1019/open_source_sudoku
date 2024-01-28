import 'dart:math';

import 'location.dart';
import 'sudoku_grid.dart';

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

  static Future<(NumericGrid, NumericGrid)> generatePuzzle(int givens) async {
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

  (NumericGrid, NumericGrid) removeDigits(int givens) {
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

    return (this, solution);
  }
}