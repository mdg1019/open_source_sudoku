import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku/utils/generator.dart';
import 'package:sudoku/utils/shared.dart';

void main() {
  test('test Generator.fillBox()', () {
    Puzzle puzzle = Shared.createEmptyPuzzle();

    Generator.fillBox(puzzle, 0, 0);

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

  test('test generator.fillDiagonalBoxes()', () {
    Puzzle puzzle = Shared.createEmptyPuzzle();

    Generator.fillDiagonalBoxes(puzzle);

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

  test('test Generator.removeDigits()', () {
    Puzzle puzzle = [
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

    GeneratedPuzzle generatedPuzzle = Generator.removeDigits(puzzle, 30);

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

  test('test Generator.generatePuzzle()', () async {
    GeneratedPuzzle generatedPuzzle = await Generator.generatePuzzle(30);

    expect(Shared.isSolved(generatedPuzzle.solution), true);
  });
}