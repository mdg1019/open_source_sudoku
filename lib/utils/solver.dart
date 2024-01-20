import 'package:sudoku/utils/shared.dart';

class Solver {
  static solvePuzzle(Puzzle puzzle) async {
    if (Shared.isSolved(puzzle)) {
      return true;
    }

    Location? emptyCell = Shared.findEmptyCell(puzzle)!;

    for (int number = 1; number <= 9; number++) {
      if (Shared.isValidPlacement(puzzle, emptyCell.row, emptyCell.col, number)) {
        puzzle[emptyCell.row][emptyCell.col] = number;

        if (await solvePuzzle(puzzle)) {
          return true;
        }

        puzzle[emptyCell.row][emptyCell.col] = 0;
      }
    }

    return false;
  }
}