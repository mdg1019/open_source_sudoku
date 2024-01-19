import 'package:sudoku/utils/shared.dart';

class Solver {
  static solvePuzzle(PuzzleGrid puzzle) async {
    if (Shared.isSolved(puzzle)) {
      return true;
    }

    Location? emptyCell = Shared.findEmptyCell(puzzle)!;

    for (int number = 1; number <= 9; number++) {
      if (Shared.isValidPlacement(puzzle, emptyCell.row, emptyCell.column, number)) {
        puzzle[emptyCell.row][emptyCell.column] = number;

        if (await solvePuzzle(puzzle)) {
          return true;
        }

        puzzle[emptyCell.row][emptyCell.column] = 0;
      }
    }

    return false;
  }
}