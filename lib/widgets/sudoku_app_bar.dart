import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';
import '../shared/utils.dart';

class SudokuAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SudokuAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider).value!;

    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: Utils.getTheme(settings.themeType).appBarThemeTextStyle,
      ),
      actions: [
        IconButton(
          icon: Icon(Utils.getTheme(settings.themeType).appBarThemeIcon),
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
