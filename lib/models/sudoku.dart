import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/shared/pregenerated_puzzles.dart';

import '../shared/difficulty_levels.dart';
import '../shared/display_grid.dart';
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

  Sudoku({required (NumericGrid, NumericGrid) puzzle, required this.difficultyLevel}) {
    displayGrid = DisplayGrid.fromGeneratedPuzzle(puzzle);

    cursor = displayGrid.findEmptyCell()!;
  }

  Sudoku.fromJson(Map<String, dynamic> json)
      : difficultyLevel = json['difficultyLevel'],
        displayGrid = DisplayGrid.fromJson(json['displayGrid']),
        cursor = Location.fromJson(json['cursor']),
        mistakes = json['mistakes'],
        isNotesMode = json['isNotesMode'];

  Map<String, dynamic> toJson() => {
    'difficultyLevel': difficultyLevel,
    'displayGrid': displayGrid,
    'cursor': cursor,
    'mistakes': mistakes,
    'isNotesMode': isNotesMode
  };

  static (NumericGrid, NumericGrid) getPuzzle(String level) {
    Random rng = Random();

    PreGeneratedPuzzle preGeneratedPuzzle = switch (level) {
      DifficultyLevel.easy => PreGeneratedPuzzle.easyPuzzles[rng.nextInt(PreGeneratedPuzzle.easyPuzzles.length)],
      DifficultyLevel.medium => PreGeneratedPuzzle.mediumPuzzles[rng.nextInt(PreGeneratedPuzzle.mediumPuzzles.length)],
      DifficultyLevel.hard => PreGeneratedPuzzle.hardPuzzles[rng.nextInt(PreGeneratedPuzzle.hardPuzzles.length)],
      DifficultyLevel.expert => PreGeneratedPuzzle.expertPuzzles[rng.nextInt(PreGeneratedPuzzle.expertPuzzles.length)],
      _ => throw Exception('Invalid difficulty level')
    };

    return (
    NumericGrid.fromString(preGeneratedPuzzle!.start),
    NumericGrid.fromString(preGeneratedPuzzle!.solution)
    );
  }

  static Future<Sudoku> getSudoku() async {
    return Utils.getJson('sudoku.json',
      (json) => Sudoku.fromJson(json),
      Sudoku(puzzle: Sudoku.getPuzzle(DifficultyLevel.easy), difficultyLevel: DifficultyLevel.easy));
  }

  static Future<void> saveSudoku(Sudoku sudoku) async {
    await Utils.saveJson(sudoku.toJson(), 'sudoku.json');
  }
}

@riverpod
class SudokuNotifier extends _$SudokuNotifier {
  @override
  FutureOr<Sudoku> build() async {
    return await Sudoku.getSudoku();
  }

  @override
  bool updateShouldNotify(AsyncValue<Sudoku> previous, AsyncValue<Sudoku> next) {

    (() async {
      await Sudoku.saveSudoku(next.value!);
    })();

    return true;
  }

  void newPuzzle(String level) {
    state = AsyncValue.data(Sudoku(puzzle: Sudoku.getPuzzle(level), difficultyLevel: level));
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
      } else
      {
        List<Location> cells = newState.displayGrid.getLocationsInLineOfSight(newState.cursor!.row, newState.cursor!.col);
        for (var location in cells) {
          PuzzleCell cell = newState.displayGrid[location.row][location.col];

          if (cell.notes.contains(number)) {
            cell.notes.remove(number);
          }}
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
