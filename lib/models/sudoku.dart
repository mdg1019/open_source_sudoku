import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../shared/difficulty_levels.dart';
import '../shared/display_grid.dart';
import '../shared/generated_puzzle.dart';
import '../shared/location.dart';
import '../shared/numeric_grid.dart';
import '../shared/puzzle_cell.dart';
import '../shared/utils.dart';

part 'sudoku.g.dart';

class Sudoku {
  final String difficultyLevel;
  late DisplayGrid displayGrid;
  Location cursor = Location(0, 0);
  int mistakes = 0;
  bool isNotesMode = false;

  Sudoku({required GeneratedPuzzle puzzle, required this.difficultyLevel}) {
    displayGrid = DisplayGrid.fromGeneratedPuzzle(puzzle);

    cursor = displayGrid.findEmptyCell()!;
  }
}

@riverpod
class SudokuNotifier extends _$SudokuNotifier {
  @override
  FutureOr<Sudoku> build() async {
    return Sudoku(
      puzzle: await NumericGrid.generatePuzzle(
        Utils.getGivens(DifficultyLevel.easy),
      ),
      difficultyLevel: DifficultyLevel.easy,
    );
  }

  void newPuzzle(String level) async {
    GeneratedPuzzle newPuzzle =
        await NumericGrid.generatePuzzle(Utils.getGivens(level));

    state = AsyncValue.data(Sudoku(puzzle: newPuzzle, difficultyLevel: level));
  }

  void resetPuzzle() {
    Sudoku resetSudoku = state.value!;

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        PuzzleCell cell = resetSudoku.displayGrid[r][c];

        cell.current = cell.starting;
        cell.notes = [];
      }
    }

    resetSudoku.mistakes = 0;
    resetSudoku.cursor = resetSudoku.displayGrid.findEmptyCell()!;
    resetSudoku.isNotesMode = false;

    state = AsyncValue.data(resetSudoku);
  }

  void setCursorLocation(int row, int col) {
    Sudoku newState = state.value!;
    newState.cursor = Location(row, col);

    state = AsyncValue.data(newState);
  }

  void numberPressed(int number) {
    Sudoku newState = state.value!;
    PuzzleCell cell =
        newState.displayGrid![newState.cursor!.row][newState.cursor!.col];

    if (cell.current == cell.solution) return;

    if (newState.isNotesMode) {
      if (cell.notes.contains(number)) {
        cell.notes.remove(number);
      } else {
        cell.notes.add(number);
      }
    } else {
      cell.current = number;

      if (cell.current != cell.solution) {
        newState.mistakes++;
      }
    }

    state = AsyncValue.data(newState);
  }

  void toggleNotesMode() {
    Sudoku newState = state.value!;
    newState.isNotesMode = !newState.isNotesMode;

    state = AsyncValue.data(newState);
  }

  void eraseCell() {
    Sudoku newState = state.value!;
    PuzzleCell cell =
        newState.displayGrid![newState.cursor!.row][newState.cursor!.col];

    if (cell.current == cell.solution) return;

    if (cell.current != 0) {
      cell.current = 0;
    } else  {
      cell.notes = [];
    }

    state = AsyncValue.data(newState);
  }
}
