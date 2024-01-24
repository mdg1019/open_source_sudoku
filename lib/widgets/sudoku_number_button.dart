import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';
import '../shared/utils.dart';

class SudokuNumberButton extends ConsumerWidget {
  final int number;
  final Function()? onPressed;

  const SudokuNumberButton(this.number, {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Settings settings = ref.watch(settingsNotifierProvider).value!;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          if (onPressed != null) onPressed!();
        },
        splashColor: Utils.getTheme(settings.themeType).splashColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 32.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
