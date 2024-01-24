import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku/utils/shared.dart';
import 'package:sudoku/utils/solver.dart';

void main() {
  test('test Solver.solvePuzzle() when puzzle can be solved', () async {
    Puzzle puzzle = [
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

    expect(await Solver.solvePuzzle(puzzle), true);

    Puzzle expected = [
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

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        expect(puzzle[r][c], expected[r][c]);
      }
    }
  });

  test('test Solver.solvePuzzle() when puzzle cannot be solved', () async {
    Puzzle puzzle = [
      [2, 0, 0, 9, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 6, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 6, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [5, 0, 2, 6, 0, 0, 4, 0, 7],
      [0, 0, 0, 0, 0, 4, 1, 0, 0],
      [0, 0, 0, 0, 9, 8, 0, 2, 3],
      [0, 0, 0, 0, 0, 3, 0, 8, 0],
      [0, 0, 5, 0, 1, 0, 0, 0, 0],
    ];

    expect(await Solver.solvePuzzle(puzzle), false);
  });
}