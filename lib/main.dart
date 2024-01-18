import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sudoku/screens/home_screen.dart';
import 'package:sudoku/themes/dark_theme.dart';
import 'package:sudoku/themes/light_theme.dart';
import 'package:sudoku/utils/settings.dart';
import 'package:sudoku/utils/shared.dart';
import 'package:sudoku/utils/generator.dart';

void main()  {
  GeneratedPuzzle puzzle = Generator.generatePuzzle(30);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    const String title = 'Sudoku';

    return MaterialApp(
      theme: (Settings.instance.get().theme == SudokuTheme.light) ? LightTheme.theme: DarkTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(title),
      },
    );
  }
}
