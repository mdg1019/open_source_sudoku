import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: title),
      body: Center(
        child: Text('Sudoku'),
      ),);
  }
}
