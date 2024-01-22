import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/widgets/sudoku_number_button.dart';

class SudokuNumbersBar extends ConsumerWidget {
  const SudokuNumbersBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<SudokuNumberButton>.generate(
        9,
            (index) {
          return SudokuNumberButton(index + 1,
              onPressed: () {});
        },
      ),
    );
  }
}