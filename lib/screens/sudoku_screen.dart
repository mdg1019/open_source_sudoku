import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';
import '../models/sudoku.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/puzzle_cell_widget.dart';

class SudokuScreen extends ConsumerWidget {
  final String title;

  const SudokuScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSudoku = ref.watch(sudokuNotifierProvider);
    final settings = ref.watch(settingsNotifierProvider).value!;

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: asyncSudoku.when(
        data: (sudoku) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              crossAxisCount: 9,
              children: List.generate(81, (index) {
                int row = index ~/ 9;
                int col = index % 9;

                return PuzzleCellWidget(sudoku: sudoku, settings: settings, row: row, col: col);
              }),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const Text('Error'),
      ),
    );
  }
}
