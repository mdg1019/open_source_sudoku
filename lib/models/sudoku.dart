import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/utils/generator.dart';
import 'package:sudoku/utils/shared.dart';

part 'sudoku.g.dart';

class Sudoku {
  final GeneratedPuzzle? puzzle;

  Sudoku({this.puzzle});
}

@riverpod
class SudokuNotifier extends _$SudokuNotifier {
  @override
  FutureOr<Sudoku> build() async {
    return Sudoku(puzzle: await Generator.generatePuzzle(30));
  }

  void setPuzzle() async {
    AsyncValue<Sudoku> newState = state;
    state = AsyncValue.data(Sudoku(puzzle: await Generator.generatePuzzle(30)));
  }
}

