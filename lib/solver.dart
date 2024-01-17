import 'package:sudoku/shared.dart';

class Solver {
  static solvePuzzle(List<List<int>> puzzle) {
    if (Shared.isSolved(puzzle)) {
      return true;
    }

    Location emptyCell = Shared.findEmptyCell(puzzle);

    for (int number = 1; number <= 9; number++) {
      if (Shared.isValidPlacement(puzzle, emptyCell.row, emptyCell.column, number)) {
        puzzle[emptyCell.row][emptyCell.column] = number;

        if (solvePuzzle(puzzle)) {
          return true;
        }

        puzzle[emptyCell.row][emptyCell.column] = 0;
      }
    }

    return false;
  }
}