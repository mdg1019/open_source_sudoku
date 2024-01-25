import 'package:collection/collection.dart';

import 'location.dart';

class SudokuGrid<T> {
  late List<List<T>> grid;
  late bool Function(T, int) hasNumber;

  SudokuGrid(this.grid, this.hasNumber);

  SudokuGrid.fromList(List<T> list, this.hasNumber) {
    List<List<T>> newGrid = [];
    int count = 0;

    for (int r = 0; r < 9; r++) {
      List<T> row = [];
      for (int c = 0; c < 9; c++) {
        row.add(list[count++]);
      }

      newGrid.add(row);
    }

    grid = newGrid;
  }

  List<T> operator [](int row) {
    return grid[row];
  }

  bool doesBoxHaveNumber(int row, int column, int number) {
    int r = row - row % 3;
    int c = column - column % 3;

    for (int i = r; i < r + 3; i++) {
      for (int j = c; j < c + 3; j++) {
        if (hasNumber(grid[i][j], number)) {
          return true;
        }
      }
    }

    return false;
  }

  List<Location> getLocationsInLineOfSight(int row, int col) {
    List<Location> locations = [];

    for (int i = 0; i < 9; i++) {
      noDupesAdd(locations, row, i);
      noDupesAdd(locations, i, col);
    }

    int r = row - row % 3;
    int c = col - col % 3;

    for (int i = r; i < r + 3; i++) {
      for (int j = c; j < c + 3; j++) {
        noDupesAdd(locations, i, j);
      }
    }

    return locations;
  }

  List<Location> getLocationsInLineOfSightWithNumber(int row, int col, int number) {
    return getLocationsInLineOfSight(row, col).where((l) => hasNumber(grid[l.row][l.col], number)).toList();

  }

  void noDupesAdd(List<Location> locations, int row, int col) {
    if (locations.firstWhereOrNull((l) => l.row == row && l.col == col) == null) {
      locations.add(Location(row, col));
    }
  }

  bool doesColumnHaveNumber(int column, int number) {
    for (int i = 0; i < 9; i++) {
      if (hasNumber(grid[i][column], number)) {
        return true;
      }
    }

    return false;
  }

  bool doesRowHaveNumber(int row, int number) {
    for (int i = 0; i < 9; i++) {
      if (hasNumber(grid[row][i], number)) {
        return true;
      }
    }

    return false;
  }

  Location? findEmptyCell() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (hasNumber(grid[r][c], 0)) {
          return Location(r, c);
        }
      }
    }

    return null;
  }

  bool isSolved() {
    return findEmptyCell() == null;
  }

  bool isValidPlacement(int row, int column, int number) {
    return !doesRowHaveNumber(row, number) &&
        !doesColumnHaveNumber(column, number) &&
        !doesBoxHaveNumber(row, column, number);
  }
}