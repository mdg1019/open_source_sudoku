import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sudoku/screens/home_screen.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String title = 'Sudoku';
    final settings = ref.watch(settingsNotifierProvider);

    return settings.when(
      data: (settings) {
        return MaterialApp(
          theme: (settings.theme == SudokuTheme.light)
              ? LightTheme.theme
              : DarkTheme.theme,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(title),
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('Error'),
    );
  }
}
