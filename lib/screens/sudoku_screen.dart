import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/widgets/sudoku_number_button.dart';

import '../models/settings.dart';
import '../models/sudoku.dart';
import '../shared/utils.dart';
import '../widgets/sudoku_app_bar.dart';
import '../widgets/sudoku_icon_bar.dart';
import '../widgets/sudoku_numbers_bar.dart';
import '../widgets/sudoku_puzzle_cell.dart';
import '../widgets/sudoku_icon_button.dart';

class SudokuScreen extends ConsumerWidget {
  final String title;

  const SudokuScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSudoku = ref.watch(sudokuNotifierProvider);
    final settings = ref.watch(settingsNotifierProvider).value!;

    return Scaffold(
      appBar: SudokuAppBar(title: title),
      body: asyncSudoku.when(
        data: (sudoku) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    right: 10.0,
                    bottom: 5.0,
                    left: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sudoku.difficultyLevel,
                          style: Utils.getTheme(settings.themeType)
                              .difficultyTextStyle),
                      Text('Mistakes: ${sudoku.mistakes}',
                          style: Utils.getTheme(settings.themeType)
                              .mistakesTextStyle),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Utils.getTheme(settings.themeType)
                          .gridBoxBorderColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 9,
                    children: List.generate(81, (index) {
                      int row = index ~/ 9;
                      int col = index % 9;

                      return SudokuPuzzleCell(
                          sudoku: sudoku,
                          settings: settings,
                          row: row,
                          col: col);
                    }),
                  ),
                ),
                const Column(
                  children: [
                    SudokuIconBar(),
                    SudokuNumbersBar(),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return const Text('Error');
        },
      ),
    );
  }
}
