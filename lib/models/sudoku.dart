import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/utils/generator.dart';
import 'package:sudoku/utils/shared.dart';

part 'sudoku.g.dart';

class PuzzleCell {
  List<int> notes = [];
  int value = 0;
  int solution = 0;

  PuzzleCell({required this.value, required this.solution});
}

class Sudoku {
  final GeneratedPuzzle? puzzle;
  List<List<PuzzleCell>>? grid;

  Sudoku({this.puzzle}) {
    if (puzzle != null) {
      grid = [];

      for (int r = 0; r < 9; r++) {
        List<PuzzleCell> row = [];

        for (int c = 0; c < 9; c++) {
          PuzzleCell puzzleCell = PuzzleCell(
              value: puzzle!.starting[r][c],
              solution: puzzle!.solution[r][c]
          );

          row.add(puzzleCell);
        }

        grid!.add(row);
      }
    } else {
      grid = null;
    }
  }
}

@riverpod
class SudokuNotifier extends _$SudokuNotifier {
  @override
  FutureOr<Sudoku> build() async {
    return Sudoku(puzzle: await Generator.generatePuzzle(30));
  }

  void newPuzzle() async {
    GeneratedPuzzle newPuzzle = await Generator.generatePuzzle(30);

    state = AsyncValue.data(Sudoku(puzzle: newPuzzle));
  }
}

