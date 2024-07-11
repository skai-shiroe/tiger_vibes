import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimation extends StatefulWidget {
  const DelayedAnimation({super.key, required this.child, required this.delay});
  final Widget child;
  final int delay;
  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animOffset;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    final curve = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animOffset = Tween<Offset>(
      begin: Offset(0.0, -0.5),
      end: Offset.zero,
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      controller.forward();
    });
  }

  Widget build(BuildContext context) {
    return  FadeTransition(
      opacity: controller,
      child: SlideTransition(
        position: animOffset,
        child: widget.child,
        ),
    );
  }
}
