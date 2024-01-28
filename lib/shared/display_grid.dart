import 'numeric_grid.dart';
import 'puzzle_cell.dart';
import 'sudoku_grid.dart';

class DisplayGrid extends SudokuGrid<PuzzleCell> {
  static bool _predicate(PuzzleCell a, int b) {
    return  a.current == b;
  }

  DisplayGrid(List<List<PuzzleCell>> grid) : super(grid, _predicate);

  DisplayGrid.fromGeneratedPuzzle((NumericGrid, NumericGrid) puzzle) : super([], _predicate) {
    var (starting, solution) = puzzle;

    for (int r = 0; r < 9; r++) {
      List<PuzzleCell> row = [];

      for (int c = 0; c < 9; c++) {
        PuzzleCell puzzleCell = PuzzleCell(
          starting: starting[r][c],
          current: starting[r][c],
          solution: solution[r][c],
        );

        row.add(puzzleCell);
      }

      grid.add(row);
    }
  }

  DisplayGrid.fromJson(Map<String, dynamic> json) : super([], _predicate) {
    List<List<dynamic>> listOfLists = List<List<dynamic>>.from(json['grid']);

    grid = [];

    for (int r = 0; r < 9; r++) {
      List<PuzzleCell> row = listOfLists[r].map((dynamic cell) =>
          PuzzleCell.fromJson(cell)).toList();

      grid.add(row);
    }
  }

  Map<String, dynamic> toJson() => { 'grid': grid };
}