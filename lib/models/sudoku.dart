import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sudoku/utils/generator.dart';
import 'package:sudoku/utils/shared.dart';

part 'sudoku.g.dart';

typedef PuzzleGrid = List<List<PuzzleCell>>;

class PuzzleCell {
  List<int> notes = [];
  int current = 0;
  int solution = 0;

  PuzzleCell({required this.current, required this.solution});
}

class Sudoku {
  final GeneratedPuzzle? puzzle;
  PuzzleGrid? puzzleGrid;
  Location? cursor = Location(0, 0);

  Sudoku({this.puzzle}) {
    if (puzzle != null) {
      generatePuzzleGrid();
    } else {
      puzzleGrid = null;
    }
  }

  void generatePuzzleGrid () {
    puzzleGrid = [];

    for (int r = 0; r < 9; r++) {
      List<PuzzleCell> row = [];

      for (int c = 0; c < 9; c++) {
        PuzzleCell puzzleCell = PuzzleCell(
            current: puzzle!.starting[r][c],
            solution: puzzle!.solution[r][c]
        );

        row.add(puzzleCell);
      }

      puzzleGrid!.add(row);
    }

    cursor = Shared.findEmptyCell(puzzle!.starting);
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

  void setCursorLocation(int row, int col) {
    Sudoku newState = state.value!;
    newState.cursor = Location(row, col);

    state = AsyncValue.data(newState);
  }
}

