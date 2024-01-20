

import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../models/sudoku.dart';

class PuzzleCellWidget extends StatelessWidget {
  const PuzzleCellWidget({
    super.key,
    required this.sudoku,
    required this.settings,
    required this.row,
    required this.col,
  });

  final Sudoku sudoku;
  final Settings settings;
  final int row;
  final int col;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: settings.theme == SudokuTheme.light ? Colors.black : Colors.white,
          width: 0.5,
        ),
      ),
      child: Center(
        child: Text(sudoku.grid![row][col].value == 0
            ? ''
            : sudoku.grid![row][col].value.toString(),
        ),
      ),
    );
  }
}