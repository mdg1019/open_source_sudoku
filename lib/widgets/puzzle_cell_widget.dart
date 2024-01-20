import 'package:flutter/material.dart';

import '../interfaces/sudoku_theme.dart';
import '../models/settings.dart';
import '../models/sudoku.dart';
import '../utils/shared.dart';

class PuzzleCellWidget extends StatelessWidget {
  PuzzleCellWidget({
    super.key,
    required this.sudoku,
    required this.settings,
    required this.row,
    required this.col,
  }) {
    puzzleCell = sudoku.grid![row][col];
    theme = Shared.getTheme(settings.themeType);
  }

  final Sudoku sudoku;
  final Settings settings;
  final int row;
  final int col;
  PuzzleCell? puzzleCell;
  SudokuTheme? theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: row % 3 == 0 ? theme!.gridBoxBorderColor : theme!.gridInnerBorderColor,
            width: 1.0,
          ),
          right: BorderSide(
            color: theme!.gridBoxBorderColor,
            width: col == 8 ? 1.0 : 0.0
          ),
          left: BorderSide(
            color: col % 3 == 0 ? theme!.gridBoxBorderColor : theme!.gridInnerBorderColor,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: theme!.gridBoxBorderColor,
            width: row == 8 ? 1.0 : 0.0,
          ),
        ),
      ),
      child: Center(
        child: Text(puzzleCell!.value == 0
            ? ''
            : puzzleCell!.value.toString(),
          style: theme!.currentValueTextStyle,
        ),
      ),
    );
  }
}