import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/constants/difficulty_levels.dart';
import 'package:sudoku/widgets/sudoku_icon_button.dart';

import '../models/settings.dart';
import '../models/sudoku.dart';
import '../utils/shared.dart';

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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Shared.getTheme(
                          ref.watch(settingsNotifierProvider).value!.themeType)
                      .backgroundColor,
                  surfaceTintColor: Colors.transparent,
                  title: const Text('Reset Puzzle'),
                  content:
                      const Text('Are you sure you want to reset the puzzle?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(sudokuNotifierProvider.notifier).resetPuzzle();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        SudokuIconButton(
          'New',
          icon: Icons.autorenew,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  backgroundColor: Shared.getTheme(
                          ref.watch(settingsNotifierProvider).value!.themeType)
                      .backgroundColor,
                  surfaceTintColor: Colors.transparent,
                  title: const Text('New Puzzle'),
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        'Select a difficulty level:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        ref.read(sudokuNotifierProvider.notifier).newPuzzle(DifficultyLevel.easy);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Easy'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        ref.read(sudokuNotifierProvider.notifier).newPuzzle(DifficultyLevel.medium);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Medium'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        ref.read(sudokuNotifierProvider.notifier).newPuzzle(DifficultyLevel.hard);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hard'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        ref.read(sudokuNotifierProvider.notifier).newPuzzle(DifficultyLevel.expert);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Expert'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
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
