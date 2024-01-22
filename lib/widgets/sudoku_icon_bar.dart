import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/widgets/sudoku_icon_button.dart';

import '../models/sudoku.dart';

class SudokuIconBar extends ConsumerWidget {
  const SudokuIconBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SudokuIconButton(
          'Reset',
          icon: Icons.refresh,
          onPressed: () {
            //ref.read(sudokuNotifierProvider.notifier).newPuzzle();
          },
        ),
        SudokuIconButton(
          'New',
          icon: Icons.autorenew,
          onPressed: () {
            ref.read(sudokuNotifierProvider.notifier).newPuzzle();
          },
        ),
        SudokuIconButton(
          'Erase',
          icon: Icons.delete,
          onPressed: () {
            //ref.read(sudokuNotifierProvider.notifier).newPuzzle();
          },
        ),
        SudokuIconButton(
          'Notes',
          icon: Icons.notes_rounded,
          onPressed: () {
            //ref.read(sudokuNotifierProvider.notifier).newPuzzle();
          },
        ),
      ],
    );
  }
}
