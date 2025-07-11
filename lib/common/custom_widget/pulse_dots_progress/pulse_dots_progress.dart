import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/pulse_dots_progress/pulse_dot.dart';

class PulseDotsProgress extends StatefulWidget {
  final int numberOfDots;

  const PulseDotsProgress({
    Key? key,
    this.numberOfDots = 4,
  }) : super(key: key);

  @override
  State<PulseDotsProgress> createState() => _PulseDotsProgressState();
}

class _PulseDotsProgressState extends State<PulseDotsProgress>
    with TickerProviderStateMixin {
  final double _beginTweenValue = 4;
  final double _endTweenValue = 8;
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  bool _isReverseAnimation = false;
  late final int _numberOfDots;

  @override
  void initState() {
    super.initState();
    _numberOfDots = widget.numberOfDots;

    for (int dotIndex = 0; dotIndex < _numberOfDots; dotIndex++) {
      // Add new animation controller for each dot
      _controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(
            milliseconds: 300,
          ),
        ),
      );

      _animations.add(
        Tween(begin: _beginTweenValue, end: _endTweenValue).animate(
          _controllers[dotIndex],
        )..addStatusListener(
            (status) {
              // If current dot has reached its max size, it should come back to its original size
              if (status == AnimationStatus.completed) {
                _controllers[dotIndex].reverse();
              }

              // Reached last dot in animation, set reverse mode to true and
              // start animation for last second dot
              if (dotIndex == _numberOfDots - 1 &&
                  _animations[dotIndex].value > _endTweenValue / 2) {
                _isReverseAnimation = true;
                _controllers[_numberOfDots - 2].forward();
              }

              // Reached first dot, set reverse mode to false and start animation
              // for next dot
              if (dotIndex == 0 &&
                  _animations[dotIndex].value > _endTweenValue / 2) {
                _isReverseAnimation = false;
                _controllers[1].forward();
              }

              // Start animation for next dot in either forward or reverse direction
              // based on is reverse animation flag
              if (_animations[dotIndex].value > _endTweenValue / 2 &&
                  dotIndex < _numberOfDots - 1) {
                if (_isReverseAnimation) {
                  _controllers[dotIndex - 1].forward();
                } else {
                  _controllers[dotIndex + 1].forward();
                }
              }
            },
          ),
      );
      // Start first dot animation
      _controllers[0].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.numberOfDots,
        (dotIndex) {
          return PulseDot(
            animation: _animations[dotIndex],
          );
        },
      ),
    );
  }
}
