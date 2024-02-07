import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku/shared/numeric_grid.dart';
import 'package:sudoku/shared/sudoku_grid.dart';

void main() {
  test('test NumericGrid.fromString()', () {
    String puzzle = "004300209005009001070060043006002087190007400050083000600000105003508690042910300";
    List<List<int>> expected = [
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ];

    NumericGrid populatedPuzzle = NumericGrid.fromString(puzzle);

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(populatedPuzzle[r][c], expected[r][c]);
      }
    }
  });

  test('test NumericGrid.empty()', () {
    NumericGrid puzzleGrid = NumericGrid.empty();

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(puzzleGrid[r][c], 0);
      }
    }
  });
}