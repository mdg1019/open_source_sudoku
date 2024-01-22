import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/models/sudoku.dart';

import '../models/settings.dart';
import '../utils/shared.dart';

class SudokuIconButton extends ConsumerWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final Function()? onPressed;

  const SudokuIconButton(this.title,
      {required this.icon, required this.onPressed, this.color, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Settings settings = ref.watch(settingsNotifierProvider).value!;
    Sudoku sudoku = ref.watch(sudokuNotifierProvider).value!;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          if (onPressed != null) onPressed!();
        },
        splashColor: Shared.getTheme(settings.themeType).splashColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Icon(icon,
                  color: color ?? Theme.of(context).iconTheme.color),
              Text(
                title,
                style: TextStyle(
                  color: color ?? Theme.of(context).iconTheme.color,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
