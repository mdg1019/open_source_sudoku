import 'dart:math';

import 'location.dart';
import 'sudoku_grid.dart';

class NumericGrid extends SudokuGrid<int> {
  static bool _predicate(int a, int b) {
    return a == b;
  }

  NumericGrid(List<List<int>> grid) : super(grid, _predicate);

  NumericGrid.empty() : super(List.generate(9, (_) => List.generate(9, (_) => 0)), _predicate);

  NumericGrid.fromString(String puzzle) : super.fromList(puzzle.split('').map((e) => int.parse(e)).toList(), _predicate);
}