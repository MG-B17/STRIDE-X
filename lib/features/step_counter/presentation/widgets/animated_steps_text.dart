import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stridex/features/step_counter/presentation/util/step_animator.dart';

/// A reusable widget that smoothly animates text displaying integer steps.
/// It uses a standard [Ticker] which is synced to the screen's refresh rate (e.g. 60 FPS),
/// ensuring ultra-smooth progression without allocating heavy overlapping Timers.
class AnimatedStepsText extends StatefulWidget {
  final int targetStep;
  final TextStyle? style;
  final String Function(int)? formatter;

  const AnimatedStepsText({
    super.key,
    required this.targetStep,
    this.style,
    this.formatter,
  });

  @override
  State<AnimatedStepsText> createState() => _AnimatedStepsTextState();
}

class _AnimatedStepsTextState extends State<AnimatedStepsText>
    with SingleTickerProviderStateMixin {
  late final StepAnimator _animator;
  late final Ticker _ticker;
  
  // Local state to track the displaying steps precisely
  // We initialize at 0 assuming we want the nice zoom-up effect on UI mount
  int _displayStep = 0;

  @override
  void initState() {
    super.initState();
    _animator = StepAnimator();
    
    // Bind a Ticker callback. This runs every frame (60 times a sec on standard displays)
    _ticker = createTicker(_onTick);
    
    // Start ticking immediately to catch up to the targetStep from 0
    _ticker.start();
  }

  void _onTick(Duration elapsed) {
    if (_animator.currentStep < widget.targetStep) {
      // Step value is below target, request the animator to increment and rebuild UI
      setState(() {
        _displayStep = _animator.animateTo(widget.targetStep);
      });
    } else {
      // We reached the target. Stop Ticker to pause the Animation Loop.
      // This strictly avoids any memory leaks or battery drainage during standby.
      _ticker.stop();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedStepsText oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.targetStep != oldWidget.targetStep) {
      if (widget.targetStep < _animator.currentStep) {
        // Edge case: Steps dropped (For instance, midnight Day switch or Sensor Reset)
        // We use the new reset method to snap both state and animator back securely
        _animator.reset(widget.targetStep);
        setState(() {
          _displayStep = widget.targetStep;
        });
      } else if (!_ticker.isTicking) {
        // Steps progressed higher. If we are paused, resume ticking to animate upwards!
        _ticker.start();
      }
    }
  }

  @override
  void dispose() {
    // Crucial: dispose the ticker strictly to avoid memory leaks off-screen!
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = widget.formatter?.call(_displayStep) ?? _displayStep.toString();
    return Text(
      displayText,
      style: widget.style,
    );
  }
}



