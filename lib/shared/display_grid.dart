import 'generated_puzzle.dart';
import 'puzzle_cell.dart';
import 'sudoku_grid.dart';

class DisplayGrid extends SudokuGrid<PuzzleCell> {
  static bool _predicate(PuzzleCell a, int b) {
    return  a.current == b;
  }

  DisplayGrid(List<List<PuzzleCell>> grid) : super(grid, _predicate);

  DisplayGrid.fromGeneratedPuzzle(GeneratedPuzzle puzzle) : super([], _predicate) {
    for (int r = 0; r < 9; r++) {
      List<PuzzleCell> row = [];

      for (int c = 0; c < 9; c++) {
        PuzzleCell puzzleCell = PuzzleCell(
          starting: puzzle.starting[r][c],
          current: puzzle.starting[r][c],
          solution: puzzle.solution[r][c],
        );

        row.add(puzzleCell);
      }

      grid.add(row);
    }
  }
}