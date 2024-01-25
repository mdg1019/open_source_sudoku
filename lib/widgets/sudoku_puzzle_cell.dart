import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/sudoku_theme.dart';
import '../models/settings.dart';
import '../models/sudoku.dart';
import '../shared/puzzle_cell.dart';
import '../shared/utils.dart';

class SudokuPuzzleCell extends ConsumerWidget {
  SudokuPuzzleCell({
    super.key,
    required this.sudoku,
    required this.settings,
    required this.row,
    required this.col,
  }) {
    puzzleCell = sudoku.displayGrid![row][col];
    theme = Utils.getTheme(settings.themeType);
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
            topLeft:
                row == 0 && col == 0 ? const Radius.circular(5.0) : Radius.zero,
            topRight:
                row == 0 && col == 8 ? const Radius.circular(5.0) : Radius.zero,
            bottomRight:
                row == 8 && col == 8 ? const Radius.circular(5.0) : Radius.zero,
            bottomLeft:
                row == 8 && col == 0 ? const Radius.circular(5.0) : Radius.zero,
          ),
        ),
        child: Center(
          child: puzzleCell!.current == 0
              ? GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  children: List.generate(9, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                            puzzleCell!.notes.contains(index + 1)
                                ? (index + 1).toString()
                                : '',
                            style: Utils.getTheme(settings.themeType)
                                .notesTextStyle),
                      ),
                    );
                  }),
                )
              : Text(
                  puzzleCell!.current == 0
                      ? ''
                      : puzzleCell!.current.toString(),
                  style: puzzleCell!.current == puzzleCell!.solution
                      ? theme!.currentValueTextStyle
                      : theme!.wrongValueTextStyle),
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    if (sudoku.cursor!.row == row && sudoku.cursor!.col == col) {
      if (puzzleCell!.current != 0 &&
          puzzleCell!.current != puzzleCell!.solution) {
        return theme!.wrongValueBackgroundColor;
      }

      if (sudoku.isNotesMode!) {
        return theme!.notesBackgroundColor;
      }

      return theme!.cursorLocationBackgroundColor;
    }

    if (sudoku.cursor!.row == row ||
        sudoku.cursor!.col == col ||
        Utils.isInSameBox(sudoku.cursor!, row, col)) {
      return theme!.highlightBackgroundColor;
    }

    return theme!.backgroundColor;
  }
}
