import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

import 'package:sudoku/shared/location.dart';
import 'package:sudoku/shared/numeric_grid.dart';

void main() {
  test('test SudokuGrid.doesBoxHaveNumber()', () {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    List<int> existingNumbers = [];

    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (puzzle[r][c] != 0) {
          existingNumbers.add(puzzle[r][c]);
        }
      }
    }

    for (int i = 0; i < existingNumbers.length; i++) {
      expect(puzzle.doesBoxHaveNumber(0, 0, existingNumbers[i]), true);
    }

    List<int> nonExistingNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].where((n) => !existingNumbers.contains(n)).toList();

    for (int i = 0; i < nonExistingNumbers.length; i++) {
      expect(puzzle.doesBoxHaveNumber(0, 0, nonExistingNumbers[i]), false);
    }
  });

  test('test SudokuGrid.doesColumnHaveNumber()', () {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    List<int> existingNumbers = [];

    for (int i = 0; i < 9; i++) {
      if (puzzle[i][0] != 0) {
        existingNumbers.add(puzzle[i][0]);
      }
    }

    for (int i = 0; i < existingNumbers.length; i++) {
      expect(puzzle.doesColumnHaveNumber(0, existingNumbers[i]), true);
    }

    List<int> nonExistingNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].where((n) => !existingNumbers.contains(n)).toList();

    for (int i = 0; i < nonExistingNumbers.length; i++) {
      expect(puzzle.doesColumnHaveNumber(0, nonExistingNumbers[i]), false);
    }
  });

  test('test SudokuGrid.doesRowHaveNumber()', () {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    List<int> existingNumbers = puzzle[0].where((n) => n != 0).toList();

    for (int i = 0; i < existingNumbers.length; i++) {
      expect(puzzle.doesRowHaveNumber(0, existingNumbers[i]), true);
    }

    List<int> nonExistingNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].where((n) => !existingNumbers.contains(n)).toList();

    for (int i = 0; i < nonExistingNumbers.length; i++) {
      expect(puzzle.doesRowHaveNumber(0, nonExistingNumbers[i]), false);
    }
  });

  test('test SudokuGrid.findEmptyCell()', () {
    NumericGrid puzzle = NumericGrid([
      [8, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    Location emptyCell = puzzle.findEmptyCell()!;

    expect(emptyCell.row == 0 && emptyCell.col == 1, true);
  });

  test('test SudokuGrid.isSolved() when false', () {
    NumericGrid puzzle = NumericGrid([
      [8, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    expect(puzzle.isSolved(), false);
  });

  test('test SudokuGrid.isSolved() when true', () {
    NumericGrid puzzle = NumericGrid([
      [8, 6, 4, 3, 7, 1, 2, 5, 9],
      [3, 2, 5, 8, 4, 9, 7, 6, 1],
      [9, 7, 1, 2, 6, 5, 8, 4, 3],
      [4, 3, 6, 1, 9, 2, 5, 8, 7],
      [1, 9, 8, 6, 5, 7, 4, 3, 2],
      [2, 5, 7, 4, 8, 3, 9, 1, 6],
      [6, 8, 9, 7, 3, 4, 1, 2, 5],
      [7, 1, 3, 5, 2, 8, 6, 9, 4],
      [5, 4, 2, 9, 1, 6, 3, 7, 8],
    ]);

    expect(puzzle.isSolved(), true);
  });

  test('test SudokuGrid.isValidPlacement()', () {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    expect(puzzle.isValidPlacement(0, 1, 1), true);
    expect(puzzle.isValidPlacement(0, 0, 4), false);
  });

  test('test SudokuGrid.noDupesAdd() does not add duplicate locations', () {
    List<Location> locations = [Location(1, 1), Location(2, 2)];
    NumericGrid grid = NumericGrid.empty();

    grid.noDupesAdd(locations, 1, 1);
    expect(locations.length, 2);

    grid.noDupesAdd(locations, 3, 3);
    expect(locations.length, 3);
  });

  test('test SudokuGrid.getLocationsInLineOfSight() returns all undupped locations', () {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    List<Location> locations = puzzle.getLocationsInLineOfSight(2, 2);

    expect(locations.length, 21);
    expect(locations.firstWhereOrNull((l) => l.row == 0 && l.col == 0) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 0 && l.col == 1) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 0 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 1 && l.col == 0) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 1 && l.col == 1) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 1 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 0) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 1) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 3) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 4) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 5) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 6) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 7) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 8) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 3 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 4 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 5 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 6 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 7 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 8 && l.col == 2) != null, true);
  });

  test('test SudokuGrid.getLocationsInLineOfSightWithNumber() returns all undupped locations', () {
    NumericGrid puzzle = NumericGrid([
      [0, 0, 4, 3, 0, 0, 2, 0, 9],
      [0, 0, 5, 0, 0, 9, 0, 0, 1],
      [0, 7, 0, 0, 6, 0, 0, 4, 3],
      [0, 0, 6, 0, 0, 2, 0, 8, 7],
      [1, 9, 0, 0, 0, 7, 4, 0, 0],
      [0, 5, 0, 0, 8, 3, 0, 0, 0],
      [6, 0, 0, 0, 0, 0, 1, 0, 5],
      [0, 0, 3, 5, 0, 8, 6, 9, 0],
      [0, 4, 2, 9, 1, 0, 3, 0, 0],
    ]);

    List<Location> locations = puzzle.getLocationsInLineOfSightWithNumber(2, 2, 4);

    expect(locations.length, 2);
    expect(locations.firstWhereOrNull((l) => l.row == 0 && l.col == 2) != null, true);
    expect(locations.firstWhereOrNull((l) => l.row == 2 && l.col == 7) != null, true);
  });
}