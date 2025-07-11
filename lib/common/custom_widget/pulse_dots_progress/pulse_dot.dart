import 'package:flutter/material.dart';

class PulseDot extends AnimatedWidget {
  const PulseDot({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: animation.value / 5,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 9,
        width: 9,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
