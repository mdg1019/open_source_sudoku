typedef PuzzleGrid = List<List<int>>;

class Location {
  final int row;
  final int column;

  Location(this.row, this.column);
}

class GeneratedPuzzle {
  final PuzzleGrid starting;
  final PuzzleGrid current;
  final PuzzleGrid solution;

  GeneratedPuzzle(this.starting, this.current, this.solution);
}

class Shared {
  static PuzzleGrid copyPuzzle(PuzzleGrid puzzle) {
    PuzzleGrid copy = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(puzzle[r][c]);
      }

      copy.add(row);
    }

    return copy;
  }

  static PuzzleGrid createEmptyPuzzle() {
    PuzzleGrid puzzle = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(0);
      }

      puzzle.add(row);
    }

    return puzzle;
  }

  static bool doesBoxHaveNumber(
      PuzzleGrid puzzle, int row, int column, int number) {
    int r = row - row % 3;
    int c = column - column % 3;

    for (int i = r; i < r + 3; i++) {
      for (int j = c; j < c + 3; j++) {
        if (puzzle[i][j] == number) {
          return true;
        }
      }
    }

    return false;
  }

  static bool doesColumnHaveNumber(PuzzleGrid puzzle, int column, int number) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[i][column] == number) {
        return true;
      }
    }

    return false;
  }

  static bool doesRowHaveNumber(PuzzleGrid puzzle, int row, int number) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[row][i] == number) {
        return true;
      }
    }

    return false;
  }

  static bool isSolved(PuzzleGrid puzzle) {
    return findEmptyCell(puzzle) == null;
  }

  static bool isValidPlacement(
      PuzzleGrid puzzle, int row, int column, int number) {
    return !doesRowHaveNumber(puzzle, row, number) &&
        !doesColumnHaveNumber(puzzle, column, number) &&
        !doesBoxHaveNumber(puzzle, row, column, number);
  }

  static Location? findEmptyCell(PuzzleGrid puzzle) {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (puzzle[r][c] == 0) {
          return Location(r, c);
        }
      }
    }

    return null;
  }

  static PuzzleGrid populatePuzzle(String rawPuzzle) {
    PuzzleGrid puzzle = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(int.parse(rawPuzzle[r * 9 + c]));
      }

      puzzle.add(row);
    }

    return puzzle;
  }

  static String puzzleToString(PuzzleGrid puzzle) {
    String rawPuzzle = "";

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        rawPuzzle += puzzle[r][c].toString();
      }
    }

    return rawPuzzle;
  }
}
