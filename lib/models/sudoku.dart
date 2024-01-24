import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/constants/difficulty_levels.dart';
import 'package:sudoku/shared/utils.dart';

import '../shared/sudoku_grid.dart';

part 'sudoku.g.dart';

typedef PuzzleGrid = List<List<PuzzleCell>>;

class PuzzleCell {
  List<int> notes = [];
  int current = 0;
  int solution = 0;

  PuzzleCell({required this.current, required this.solution});
}

class Sudoku {
  final GeneratedPuzzle puzzle;
  final String difficultyLevel;
  late DisplayGrid displayGrid;
  Location cursor = Location(0, 0);
  int mistakes = 0;
  bool isNotesMode = false;

  Sudoku({required this.puzzle, required this.difficultyLevel}) {
    displayGrid = DisplayGrid.fromSudokuNumericGrid(puzzle);

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
    state = AsyncValue.data(Sudoku(
      puzzle: state.value!.puzzle,
      difficultyLevel: state.value!.difficultyLevel,
    ));
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
