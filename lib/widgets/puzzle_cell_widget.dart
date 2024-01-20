import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interfaces/sudoku_theme.dart';
import '../models/settings.dart';
import '../models/sudoku.dart';
import '../utils/shared.dart';

class PuzzleCellWidget extends ConsumerWidget {
  PuzzleCellWidget({
    super.key,
    required this.sudoku,
    required this.settings,
    required this.row,
    required this.col,
  }) {
    puzzleCell = sudoku.puzzleGrid![row][col];
    theme = Shared.getTheme(settings.themeType);
  }

  final Sudoku sudoku;
  final Settings settings;
  final int row;
  final int col;
  PuzzleCell? puzzleCell;
  SudokuTheme? theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(sudokuNotifierProvider.notifier).setCursorLocation(row, col);
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          border: Border(
            top: row != 0
                ? BorderSide(
                    color: row % 3 == 0
                        ? theme!.gridBoxBorderColor
                        : theme!.gridInnerBorderColor,
                    width: 1.0,
                  )
                : BorderSide.none,
            left: col != 0
                ? BorderSide(
                    color: col % 3 == 0
                        ? theme!.gridBoxBorderColor
                        : theme!.gridInnerBorderColor,
                    width: 1.0,
                  )
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: row == 0 && col == 0 ? const Radius.circular(5.0) : Radius.zero,
            topRight: row == 0 && col == 8 ? const Radius.circular(5.0) : Radius.zero,
            bottomRight: row == 8 && col == 8 ? const Radius.circular(5.0) : Radius.zero,
            bottomLeft: row == 8 && col == 0 ? const Radius.circular(5.0) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            puzzleCell!.current == 0 ? '' : puzzleCell!.current.toString(),
            style: theme!.currentValueTextStyle,
          ),
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    if (sudoku.cursor!.row == row && sudoku.cursor!.col == col) {
      return theme!.cursorLocationBackgroundColor;
    }

    if (sudoku.cursor!.row == row || sudoku.cursor!.col == col || Shared.isInSameBox(sudoku.cursor!, row, col)) {
      return theme!.highlightBackgroundColor;
    }



    return theme!.backgroundColor;
  }
}
