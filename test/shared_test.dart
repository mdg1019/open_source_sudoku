import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/utils/shared.dart';

void main() {
  test('test Shared.populatePuzzle()', () {
    String puzzle = "004300209005009001070060043006002087190007400050083000600000105003508690042910300";
    PuzzleGrid expected = [
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

    List<List<int>> populatedPuzzle = Shared.populatePuzzle(puzzle);

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(populatedPuzzle[r][c], expected[r][c]);
      }
    }
  });

  test('test Shared.puzzleToString()', () {
    PuzzleGrid puzzle = [
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

    String expected = "004300209005009001070060043006002087190007400050083000600000105003508690042910300";

    String rawPuzzle = Shared.puzzleToString(puzzle);

    expect(rawPuzzle, expected);

  });

  test('test Shared.doesRowHaveNumber()', () {
    PuzzleGrid puzzle = [
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

    List<int> existingNumbers = puzzle[0].where((n) => n != 0).toList();

    for (int i = 0; i < existingNumbers.length; i++) {
      expect(Shared.doesRowHaveNumber(puzzle, 0, existingNumbers[i]), true);
    }

    List<int> nonExistingNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].where((n) => !existingNumbers.contains(n)).toList();

    for (int i = 0; i < nonExistingNumbers.length; i++) {
      expect(Shared.doesRowHaveNumber(puzzle, 0, nonExistingNumbers[i]), false);
    }
  });

  test('test Shared.doesColumnHaveNumber()', () {
    PuzzleGrid puzzle = [
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

    List<int> existingNumbers = [];

    for (int i = 0; i < 9; i++) {
      if (puzzle[i][0] != 0) {
        existingNumbers.add(puzzle[i][0]);
      }
    }

    for (int i = 0; i < existingNumbers.length; i++) {
      expect(Shared.doesColumnHaveNumber(puzzle, 0, existingNumbers[i]), true);
    }

    List<int> nonExistingNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].where((n) => !existingNumbers.contains(n)).toList();

    for (int i = 0; i < nonExistingNumbers.length; i++) {
      expect(Shared.doesColumnHaveNumber(puzzle, 0, nonExistingNumbers[i]), false);
    }
  });

  test('test Shared.doesBoxHaveNumber()', () {
    PuzzleGrid puzzle = [
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

    List<int> existingNumbers = [];

    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (puzzle[r][c] != 0) {
          existingNumbers.add(puzzle[r][c]);
        }
      }
    }

    for (int i = 0; i < existingNumbers.length; i++) {
      expect(Shared.doesBoxHaveNumber(puzzle, 0, 0, existingNumbers[i]), true);
    }

    List<int> nonExistingNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].where((n) => !existingNumbers.contains(n)).toList();

    for (int i = 0; i < nonExistingNumbers.length; i++) {
      expect(Shared.doesBoxHaveNumber(puzzle, 0, 0, nonExistingNumbers[i]), false);
    }
  });

  test('test Shared.isValidPlacement()', () {
    PuzzleGrid puzzle = [
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

    expect(Shared.isValidPlacement(puzzle, 0, 1, 1), true);
    expect(Shared.isValidPlacement(puzzle, 0, 0, 4), false);
  });

  test('test Shared.findEmptyCell()', () {
    PuzzleGrid puzzle = [
      [8, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ];

    Location emptyCell = Shared.findEmptyCell(puzzle)!;

    expect(emptyCell.row == 0 && emptyCell.column == 1, true);
  });

  test('test Shared.isSolved() when false', () {
    PuzzleGrid puzzle = [
      [8, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ];

    expect(Shared.isSolved(puzzle), false);
  });

  test('test Shared.isSolved() when true', () {
    PuzzleGrid puzzle = [
      [8, 6, 4, 3, 7, 1, 2, 5, 9],
      [3, 2, 5, 8, 4, 9, 7, 6, 1],
      [9, 7, 1, 2, 6, 5, 8, 4, 3],
      [4, 3, 6, 1, 9, 2, 5, 8, 7],
      [1, 9, 8, 6, 5, 7, 4, 3, 2],
      [2, 5, 7, 4, 8, 3, 9, 1, 6],
      [6, 8, 9, 7, 3, 4, 1, 2, 5],
      [7, 1, 3, 5, 2, 8, 6, 9, 4],
      [5, 4, 2, 9, 1, 6, 3, 7, 8],
    ];

    expect(Shared.isSolved(puzzle), true);
  });

  test('test Shared.copyPuzzle() when true', () {
    PuzzleGrid puzzle1 = [
      [8, 6, 4, 3, 7, 1, 2, 5, 9],
      [3, 2, 5, 8, 4, 9, 7, 6, 1],
      [9, 7, 1, 2, 6, 5, 8, 4, 3],
      [4, 3, 6, 1, 9, 2, 5, 8, 7],
      [1, 9, 8, 6, 5, 7, 4, 3, 2],
      [2, 5, 7, 4, 8, 3, 9, 1, 6],
      [6, 8, 9, 7, 3, 4, 1, 2, 5],
      [7, 1, 3, 5, 2, 8, 6, 9, 4],
      [5, 4, 2, 9, 1, 6, 3, 7, 8],
    ];

    PuzzleGrid puzzle2 = Shared.copyPuzzle(puzzle1);

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(puzzle1[r][c], puzzle2[r][c]);
      }
    }
  });
}