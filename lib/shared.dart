class Location {
  final int row;
  final int column;

  Location(this.row, this.column);
}

class Shared {
  static populatePuzzle(String rawPuzzle) {
    List<List<int>> puzzle = [];

    for (int r = 0; r < 9; r++) {
      List<int> row = [];

      for (int c = 0; c < 9; c++) {
        row.add(int.parse(rawPuzzle[r * 9 + c]));
      }

      puzzle.add(row);
    }

    return puzzle;
  }

  static puzzleToString(List<List<int>> puzzle) {
    String rawPuzzle = "";

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        rawPuzzle += puzzle[r][c].toString();
      }
    }

    return rawPuzzle;
  }

  static doesRowHaveNumber(List<List<int>> puzzle, int row, int number) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[row][i] == number) {
        return true;
      }
    }

    return false;
  }

  static doesColumnHaveNumber(List<List<int>> puzzle, int column, int number) {
    for (int i = 0; i < 9; i++) {
      if (puzzle[i][column] == number) {
        return true;
      }
    }

    return false;
  }

  static doesBoxHaveNumber(List<List<int>> puzzle, int row, int column, int number) {
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

  static isValidPlacement(List<List<int>> puzzle, int row, int column, int number) {
    return
      !doesRowHaveNumber(puzzle, row, number) &&
      !doesColumnHaveNumber(puzzle, column, number) &&
      !doesBoxHaveNumber(puzzle, row, column, number);
  }

  static findEmptyCell(List<List<int>> puzzle) {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (puzzle[r][c] == 0) {
          return Location(r, c);
        }
      }
    }

    return null;
  }

  static isSolved(List<List<int>> puzzle) {
    return findEmptyCell(puzzle) == null;
  }
}