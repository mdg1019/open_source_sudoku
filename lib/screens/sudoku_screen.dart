import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sudoku.dart';
import '../widgets/app_bar_widget.dart';

class SudokuScreen extends ConsumerWidget {
  final String title;

  const SudokuScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sudoku = ref.watch(sudokuNotifierProvider);

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: sudoku.when(
        data: (sudoku) {
          return const Text('sudoku created');
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const Text('Error'),
      ),
    );
  }
}
