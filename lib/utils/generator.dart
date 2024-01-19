import 'dart:math';

import 'package:sudoku/utils/shared.dart';
import 'package:sudoku/utils/solver.dart';

class Generator {
  static void fillDiagonalBoxes(PuzzleGrid puzzle) {
    for (int i = 0; i < 9; i += 3) {
      fillBox(puzzle, i, i);
    }
  }

  static void fillBox(PuzzleGrid puzzle, int row, int column) {
    List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    numbers.shuffle();

    for (int r = row; r < row + 3; r++) {
      for (int c = column; c < column + 3; c++) {
        puzzle[r][c] = numbers.removeLast();
      }
    }
  }

  static Future<GeneratedPuzzle> generatePuzzle(int givens) async {
    while (true) {
      PuzzleGrid puzzle = Shared.createEmptyPuzzle();

      Generator.fillDiagonalBoxes(puzzle);

      if (await Solver.solvePuzzle(puzzle)) {
        return Generator.removeDigits(puzzle, givens);
      }
    }
  }

  static GeneratedPuzzle removeDigits(PuzzleGrid puzzle, int givens) {
    PuzzleGrid solution = Shared.copyPuzzle(puzzle);
    Random rng = Random();
    int count = 0;
    int numToRemove = 81 - givens;

    while (count < numToRemove) {
      int row = rng.nextInt(9);
      int column = rng.nextInt(9);

      if (puzzle[row][column] != 0) {
        puzzle[row][column] = 0;
        count++;
      }
    }

    return GeneratedPuzzle(puzzle, puzzle, solution);
  }
}
