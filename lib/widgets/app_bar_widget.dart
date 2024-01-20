import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);

    return AppBar(
      title: Center(
        child: Text(
          title,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(settings.value!.theme == SudokuTheme.light
              ? Icons.dark_mode
              : Icons.light_mode),
          onPressed: () {
            ref.read(settingsNotifierProvider.notifier).toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
