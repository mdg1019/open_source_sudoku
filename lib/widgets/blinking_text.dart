import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  final String text;
  bool shouldBlink;

  BlinkingText({required this.text, this.shouldBlink = true, super.key});

  @override
  BlinkingTextState createState() => BlinkingTextState();
}

class BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.shouldBlink) {
      for (int i = 0; i < 2; i++) {
        _animationController.forward(from: 0.0);
        _animationController.reverse(from: 1.0);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: widget.shouldBlink ? _animation.value : 1,
          child: Text(widget.text),
        );
      },
    );
  }
}