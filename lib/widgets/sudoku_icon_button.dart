import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';
import '../utils/shared.dart';

class SudokuIconButton extends ConsumerWidget {
  final String title;
  final Function()? onPressed;

  const SudokuIconButton(this.title, {this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Settings settings = ref.watch(settingsNotifierProvider).value!;

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
              const Icon(Icons.refresh),
              Text(
                title,
                style: const TextStyle(
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
