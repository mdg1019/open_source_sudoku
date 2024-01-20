import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sudoku/screens/sudoku_screen.dart';
import 'package:sudoku/themes/dark_theme.dart';
import 'package:sudoku/themes/light_theme.dart';
import 'package:sudoku/utils/shared.dart';
import 'package:sudoku/utils/generator.dart';

import 'models/settings.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String title = 'Sudoku';
    final settings = ref.watch(settingsNotifierProvider);

    return settings.when(
      data: (settings) {
        return MaterialApp(
          theme: Shared.getTheme(settings.themeType).theme,
          initialRoute: '/',
          routes: {
            '/': (context) => const SudokuScreen(title),
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('Error'),
    );
  }
}
