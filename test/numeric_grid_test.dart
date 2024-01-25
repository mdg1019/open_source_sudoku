import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku/shared/generated_puzzle.dart';
import 'package:sudoku/shared/numeric_grid.dart';
import 'package:sudoku/shared/sudoku_grid.dart';

void main() {
  test('test NumericGrid.copy()', () {
    NumericGrid puzzle1 = NumericGrid([
      [8, 6, 4, 3, 7, 1, 2, 5, 9],
      [3, 2, 5, 8, 4, 9, 7, 6, 1],
      [9, 7, 1, 2, 6, 5, 8, 4, 3],
      [4, 3, 6, 1, 9, 2, 5, 8, 7],
      [1, 9, 8, 6, 5, 7, 4, 3, 2],
      [2, 5, 7, 4, 8, 3, 9, 1, 6],
      [6, 8, 9, 7, 3, 4, 1, 2, 5],
      [7, 1, 3, 5, 2, 8, 6, 9, 4],
      [5, 4, 2, 9, 1, 6, 3, 7, 8],
    ]);

    SudokuGrid puzzle2 = puzzle1.copy();

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(puzzle1[r][c], puzzle2[r][c]);
      }
    }
  });

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

  test('test NumericGrid.fillBox()', () {
    NumericGrid puzzle = NumericGrid.empty();

    puzzle.fillBox(0, 0);

    List<int> numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];

    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        numbers[puzzle[r][c] - 1]++;
      }
    }

    for (int i = 0; i < 9; i++) {
      expect(numbers[i], 1);
    }
  });

  test('test NumericGrid.fillDiagonalBoxes()', () {
    NumericGrid puzzle = NumericGrid.empty();

    puzzle.fillDiagonalBoxes();

    for (int i = 0; i < 9; i += 3) {
      List<int> numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];

      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          numbers[puzzle[i + r][i + c] - 1]++;
        }
      }

      for (int j = 0; i < 9; i++) {
        expect(numbers[j], 1);
      }
    }
  });

  test('test NumericGrid.removeDigits()', () {
    NumericGrid puzzle = NumericGrid([
      [8, 6, 4, 3, 7, 1, 2, 5, 9],
      [3, 2, 5, 8, 4, 9, 7, 6, 1],
      [9, 7, 1, 2, 6, 5, 8, 4, 3],
      [4, 3, 6, 1, 9, 2, 5, 8, 7],
      [1, 9, 8, 6, 5, 7, 4, 3, 2],
      [2, 5, 7, 4, 8, 3, 9, 1, 6],
      [6, 8, 9, 7, 3, 4, 1, 2, 5],
      [7, 1, 3, 5, 2, 8, 6, 9, 4],
      [5, 4, 2, 9, 1, 6, 3, 7, 8],
    ]);

    GeneratedPuzzle generatedPuzzle = puzzle.removeDigits(30);

    int numberOfGivens = 0;

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (generatedPuzzle.starting[r][c] != 0) {
          numberOfGivens++;
        }
      }
    }

    expect(numberOfGivens, 30);
  });

  test('test NumericGrid.generatePuzzle()', () async {
    GeneratedPuzzle generatedPuzzle = await NumericGrid.generatePuzzle(30);

    expect(generatedPuzzle.solution.isSolved(), true);
  });

  test('test NumericGrid.empty()', () {
    NumericGrid puzzleGrid = NumericGrid.empty();

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(puzzleGrid[r][c], 0);
      }
    }
  });

  test('test NumericGrid.solvePuzzle() when puzzle can be solved', () async {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    expect(await puzzle.solvePuzzle(), true);

    NumericGrid expected = NumericGrid([
      [8, 6, 4, 3, 7, 1, 2, 5, 9],
      [3, 2, 5, 8, 4, 9, 7, 6, 1],
      [9, 7, 1, 2, 6, 5, 8, 4, 3],
      [4, 3, 6, 1, 9, 2, 5, 8, 7],
      [1, 9, 8, 6, 5, 7, 4, 3, 2],
      [2, 5, 7, 4, 8, 3, 9, 1, 6],
      [6, 8, 9, 7, 3, 4, 1, 2, 5],
      [7, 1, 3, 5, 2, 8, 6, 9, 4],
      [5, 4, 2, 9, 1, 6, 3, 7, 8],
    ]);

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(puzzle[r][c], expected[r][c]);
      }
    }
  });


  test('test NumericGrid.solvePuzzle() when puzzle cannot be solved', () async {
    NumericGrid puzzle = NumericGrid([
      [2, 0, 0, 9, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 6, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 6, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [5, 0, 2, 6, 0, 0, 4, 0, 7],
      [0, 0, 0, 0, 0, 4, 1, 0, 0],
      [0, 0, 0, 0, 9, 8, 0, 2, 3],
      [0, 0, 0, 0, 0, 3, 0, 8, 0],
      [0, 0, 5, 0, 1, 0, 0, 0, 0],
    ]);

    expect(await puzzle.solvePuzzle(), false);
  }, skip: true);
}